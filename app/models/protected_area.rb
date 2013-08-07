class ProtectedArea < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :area
  attr_accessible :iucnat
  attr_accessible :code
  attr_accessible :designation_year
  attr_accessible :lat
  attr_accessible :length
  attr_accessible :long
  attr_accessible :name
  attr_accessible :nuts_code
  attr_accessible :source_db
  attr_accessible :uri

  has_and_belongs_to_many :biogeo_regions , association_foreign_key: "biogeo_region_id", join_table: "biogeo_regions_protected_areas", class_name: "BiogeoRegion"
  has_and_belongs_to_many :countries , association_foreign_key: "country_id", join_table: "countries_protected_areas", class_name: "Country"
  has_and_belongs_to_many :habitats , association_foreign_key: "habitat_id", join_table: "protected_areas_habitats", class_name: "Habitat"
  has_and_belongs_to_many :species , association_foreign_key: "species_id", join_table: "species_protected_areas", class_name: "Species"

  index_name "#{Tire::Model::Search.index_prefix}protected_areas"

  settings :analysis => {
    :analyzer => {
      :search_analyzer => {
        :tokenizer => "keyword",
        :filter => ["lowercase"]
      },
      :index_ngram_analyzer => {
        :tokenizer => "keyword",
        :filter => ["lowercase", "substring"],
        :type => "custom"
      }
    },
    :filter => {
      :substring => {
        :type => "nGram",
        :min_gram => 1,
        :max_gram => 20
      }
    }
  } do
    mapping {
      indexes :code, :type => 'string', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'
      indexes :name, :type => 'string', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'

      indexes :country, :type => 'string', :index => :not_analyzed

      indexes :biogeoregions do
        indexes :id, type: 'integer'
        indexes :bioregion_code, type: 'string', :index => :not_analyzed
        indexes :bioregion_name, :type => 'string', :index => :not_analyzed
      end

      indexes :source_db, :type => 'string', :index => :not_analyzed
      indexes :designation_year, :type => 'integer', :index => :not_analyzed
    }
  end

  def country_name
    if countries.size > 0
      countries.first.name
    else
      ''
    end
  end

  # def bioregions
  #     if biogeo_regions.nil?
  #         {}
  #     else
  #         biogeo_regions.map { |b| { :_type  => 'biogeoregion', _id: b.id, code: b.code, name: b.area_name } }
  #     end
  # end

  def to_indexed_json
    {
      :uri                    => uri,
      :code                   => code,
      :name                   => name,
      :country                => country_name,
      :biogeoregions          => biogeo_regions.map { |b| { :_type  => 'biogeo_region', _id: b.id, bioregion_code: b.code, bioregion_name: b.area_name } },
      :source_db              => source_db,
      :designation_year       => designation_year
    }.to_json
  end

  def self.search(params)

    # Facet Filter
    protected_area_filter = []
    protected_area_filter << { term: { :source_db => params[:source_db] }} if params[:source_db].present?
    protected_area_filter << { term: { :country => params[:country].split(/\//) }} if params[:country].present?
    # protected_area_filter << { term: { 'languages.name' => params[:languages].split(/\//) }} if params[:languages].present?
    # protected_area_filter << { term: { :biographical_region => params[:biographical_region] }} if params[:biographical_region].present?

    tire.search :load => true, :page => params[:page], :per_page => 20 do
      query do
        boolean do
          should   { string 'name:' + params[:query].to_s }
        end
      end if params[:query].present?

      filter :term, :source_db => params[:source_db] if params[:source_db].present?
      filter :term, :country => params[:country] if params[:country].present?

      highlight :name

      facet 'source_db' do
        terms :source_db
        facet_filter :and, protected_area_filter unless protected_area_filter.empty?
      end

      facet 'country' do
        terms :country, size: 60
        facet_filter :and, protected_area_filter unless protected_area_filter.empty?
      end

      facet 'biogeoregions', size: 20 do
        terms 'biogeoregions.area_name'
        facet_filter :and, protected_area_filter unless protected_area_filter.empty?
      end

      facet('designation_year') do
        terms :designation_year, size: 15
        facet_filter :and, protected_area_filter unless protected_area_filter.empty?
      end
    end
  end

end
