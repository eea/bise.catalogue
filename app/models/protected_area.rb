class ProtectedArea < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::AsyncCallbacks

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

  settings analysis: {
    analyzer: {
      search_analyzer: {
        tokenizer: "keyword",
        filter: %w(lowercase snowball asciifolding)
      },
      index_ngram_analyzer: {
        tokenizer: "keyword",
        filter: ["lowercase", "substring"],
        type: "custom"
      }
    },
    filter: {
      substring: {
        type: "nGram",
        min_gram: 1,
        max_gram: 20
      }
    }
  } do
    mapping {

      indexes :site do
        indexes :id, type: 'integer'
        indexes :name, type: 'string', index: :not_analyzed
        indexes :ngram_name,
                index_analyzer: 'index_ngram_analyzer' ,
                search_analyzer: 'snowball'
      end

      indexes :code, type: 'string',
              index_analyzer: 'index_ngram_analyzer',
              search_analyzer: 'search_analyzer'

      indexes :name, type: 'string',
              index_analyzer: 'index_ngram_analyzer',
              search_analyzer: 'search_analyzer'

      # indexes :country, type: 'string', index: :not_analyzed

      indexes :countries do
        indexes :id         , type: 'integer'
        indexes :name       , type: 'string', index: :not_analyzed
        indexes :ngram_name , index_analyzer: 'index_ngram_analyzer', search_analyzer: 'snowball'
      end

      indexes :species do
        indexes :id, type: 'integer'
        indexes :scientific_name, type: 'string',
                index_analyzer: 'index_ngram_analyzer',
                search_analyzer: 'search_analyzer'
      end

      indexes :habitats do
        indexes :id, type: 'integer'
        indexes :name, type: 'string',
                index_analyzer: 'index_ngram_analyzer',
                search_analyzer: 'search_analyzer'
        indexes :code, type: 'string',
                index_analyzer: 'index_ngram_analyzer',
                search_analyzer: 'search_analyzer'
      end

      indexes :biogeo_regions do
        indexes :id, type: 'integer'
        indexes :name, type: 'string',
                index_analyzer: 'index_ngram_analyzer',
                search_analyzer: 'search_analyzer'
        indexes :code, type: 'string',
                index_analyzer: 'index_ngram_analyzer',
                search_analyzer: 'search_analyzer'
      end

      indexes :source_db, type: 'string', index: :not_analyzed
      indexes :designation_year, type: 'integer', index: :not_analyzed

      indexes :published_on,
              type: 'date'
      indexes :approved           , type: 'boolean'
    }
  end

  def country_name
    if countries.size > 0
      countries.first.name
    else
      ''
    end
  end

  def site
    Site.find_by_name('EUNIS')
  end

  def to_indexed_json
    {
      site:             {
        _type: 'site',
        _id: site.id,
        name: site.name,
        ngram_name: site.name
      },
      uri: uri,
      code: code,
      name: name,
      countries: countries.map do |c|
        { _type: 'country', _id: c.id, name: c.name, ngram_name: c.name }
      end,
      species: species.map do |s|
        { _type: 'species', _id: s.id, scientific_name: s.scientific_name }
      end,
      habitats: habitats.map do |h|
        { _type: 'habitat', _id: h.id, name: h.name, code: h.habitat_code }
      end,
      biogeo_regions: biogeo_regions.map do |br|
        { _type: 'biogeo_regions', _id: br.id, name: br.area_name, code: br.code }
      end,
      source_db: source_db,
      designation_year: designation_year,
      published_on: created_at,
      approved: approved
    }.to_json
  end

  def self.search(params)

    # Facet Filter
    protected_area_filter = []
    protected_area_filter << { term: { 'site.name' => params[:site] }} if params[:site].present?
    protected_area_filter << { term: { :source_db => params[:source_db] }} if params[:source_db].present?
    protected_area_filter << { term: { :country => params[:country].split(/\//) }} if params[:country].present?

    tire.search :load => true, :page => params[:page], :per_page => 20 do
      query do
        boolean do
          should   { string 'site.ngram_name:' + params[:query].to_s }
          should   { string 'name:' + params[:query].to_s }
          should   { string 'countries.ngram_name:' + params[:query].to_s }
          should   { string 'habitats.name:' + params[:query].to_s }
        end
      end if params[:query].present?

      filter :term, 'site.name' => params[:site] if params[:site].present?
      filter :term, :source_db => params[:source_db] if params[:source_db].present?
      filter :term, 'countries.name' => params[:countries].split(/\//) if params[:countries].present?
      filter :term, :biographical_region => params[:biographical_region] if params[:biographical_region].present?

      highlight :name

      facet 'sites' do
        terms 'site.name'
        facet_filter :and, protected_area_filter unless protected_area_filter.empty?
      end

      facet 'source_db' do
        terms :source_db
        facet_filter :and, protected_area_filter unless protected_area_filter.empty?
      end

      facet 'countries' do
        terms 'countries.name', size: 60
        facet_filter :and, protected_area_filter unless protected_area_filter.empty?
      end

      # facet 'biographical_regions' do
      #   terms :biographical_region
      #   facet_filter :and, protected_area_filter unless protected_area_filter.empty?
      # end

      facet('designation_year') do
        terms :designation_year, size: 15
        facet_filter :and, protected_area_filter unless protected_area_filter.empty?
      end
    end
  end

end
