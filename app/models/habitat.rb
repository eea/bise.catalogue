class Habitat < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :code
  attr_accessible :comment
  attr_accessible :description
  attr_accessible :habitat_code
  attr_accessible :level
  attr_accessible :name
  attr_accessible :national_name
  attr_accessible :natura2000_code
  attr_accessible :originally_published_code
  attr_accessible :uri

  has_and_belongs_to_many :protected_areas , association_foreign_key: "protected_area_id" , join_table: "protected_areas_habitats", class_name: "ProtectedArea"
  has_and_belongs_to_many :species         , association_foreign_key: "species_id"        , join_table: "species_habitats"        , class_name: "Species"

  index_name "#{Tire::Model::Search.index_prefix}habitats"

  settings analysis: {
    analyzer: {
      search_analyzer: {
        type: 'custom',
        tokenizer: 'standard',
        filter: %w(lowercase snowball)
      },
      index_ngram_analyzer: {
        type: 'custom',
        tokenizer: 'standard',
        filter: %w(lowercase snowball substring)
      }
    },
    filter: {
      substring: {
        type: 'nGram',
        min_gram: 1,
        max_gram: 40,
        token_chars: %(letter digit)
      }
    }
  } do
    mapping {

      indexes :site do
        indexes :id, type: 'integer'
        indexes :name, type: 'string', index: :not_analyzed
        indexes :ngram_name, index_analyzer: 'index_ngram_analyzer' , search_analyzer: 'snowball'
      end

      indexes :uri, type: 'string', index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'
      indexes :name, type: 'string', index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'
      indexes :habitat_code, type: 'string', index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'
      indexes :level, type: 'integer', index: :not_analyzed
      indexes :description, type: 'string', index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'

      indexes :countries do
        indexes :id, type: 'integer'
        indexes :name, type: 'string' , index: :not_analyzed
        indexes :ngram_name ,
                index_analyzer: 'index_ngram_analyzer' ,
                search_analyzer: 'snowball'
      end

      indexes :published_on,
              type: 'date'
      indexes :approved           , type: 'boolean'
    }
  end

  def countries
    ret = Set.new
    if protected_areas.size > 0
      protected_areas.each do |pa|
        country = pa.countries.first
        ret.add(pa.countries.first) unless ret.include?(country) or country.nil?
      end
    end
    ret.to_a
  end

  def site
    Site.find_by_name('EUNIS')
  end

  def to_indexed_json
    {
      site:           {
        _type: 'site',
        _id: site.id,
        name: site.name,
        ngram_name: site.name
      },
      uri:             uri,
      name:            name,
      habitat_code:    habitat_code,
      natura2000_code: natura2000_code,
      level:           level,
      description:     description,
      countries:      countries.map do |c|
        { _type: 'country', _id: c.id, name: c.name, ngram_name: c.name }
      end,
      published_on:    created_at,
      approved:        approved
    }.to_json
  end

  def self.search(params)

    params[:query].gsub!(/[\+\-\:\"\~\*\!\?\{\}\[\]\(\)]/, '\\1') if params[:query].present?

    hab_filter = Array.new
    hab_filter << { term: { 'countries.name' => params[:countries].split(/\//) }} if params[:countries].present?

    tire.search load: true, page: params[:page], per_page: 10 do
      query do
        boolean do
          should   { string 'name:' + params[:query].to_s }
          should   { string 'description:' + params[:query].to_s }
        end
      end if params[:query].present?

      highlight :name

      # filter :term, 'countries.name' => params[:countries].split(/\//) if params[:countries].present?

      facet 'countries' do
        terms 'countries.name', size: 30
        facet_filter :and, hab_filter unless hab_filter.empty?
      end
    end
  end

end
