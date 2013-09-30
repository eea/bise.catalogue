class Species < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  belongs_to :taxonomy

  attr_accessible :uri
  attr_accessible :binomial_name
  attr_accessible :eunis_primary_name
  attr_accessible :genus
  attr_accessible :ignore_on_match
  attr_accessible :label
  attr_accessible :name_according_to_ID
  attr_accessible :scientific_name
  attr_accessible :scientific_name_authorship
  attr_accessible :species_code
  attr_accessible :species_group
  attr_accessible :synonym_for
  attr_accessible :taxonomic_rank
  attr_accessible :valid_name

  has_and_belongs_to_many :habitats,
                          association_foreign_key: 'habitat_id',
                          join_table: 'species_habitats',
                          class_name: 'Habitat'
  has_and_belongs_to_many :protected_areas ,
                          association_foreign_key: 'protected_area_id',
                          join_table: 'species_protected_areas',
                          class_name: 'ProtectedArea'
  has_many :vernacular_names, class_name: "SpeciesTranslation"

  index_name "#{Tire::Model::Search.index_prefix}species"

  refresh = lambda { Tire::Index.new(index_name).refresh }
  after_save(&refresh)
  after_destroy(&refresh)

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

      indexes :site do
        indexes :id, type: 'integer'
        indexes :name, type: 'string', index: :not_analyzed
        indexes :ngram_name,
                index_analyzer: 'index_ngram_analyzer',
                search_analyzer: 'snowball'
      end

      indexes :binomial_name  , type: 'string', index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'
      indexes :scientific_name, type: 'string', index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'

      indexes :vernacular_names do
        indexes :locale       , type: 'string', index: :not_analyzed
        indexes :name         , type: 'string', index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'
      end

      indexes :protected_areas do
        indexes :code         , type: 'string', index: :not_analyzed
        indexes :name         , type: 'string', index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'
      end

      indexes :authorship     , type: 'string', index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'
      indexes :created_at     , type: 'date'

      indexes :species_group  , type: 'string', index: :not_analyzed
      indexes :taxonomic_rank , type: 'string', index: :not_analyzed
      indexes :genus          , type: 'string', index: :not_analyzed

      indexes :valid_name     , type: 'boolean', index: :not_analyzed

      indexes :kingdom        , index: :not_analyzed
      indexes :phylum         , index: :not_analyzed
      indexes :classis        , index: :not_analyzed

      indexes :published_on,
              type: 'date'
      indexes :approved       , type: 'boolean'

    }
  end

  def site
    Site.find_by_name('EUNIS')
  end

  # self.to_json :methods => [:content_without_tags]
  def to_indexed_json
    {
      site:           {
        _type: 'site',
        _id: site.id,
        name: site.name,
        ngram_name: site.name
      },
      uri:             uri,
      binomial_name:   binomial_name,
      scientific_name: scientific_name,
      vernacular_names: vernacular_names.map do |vn|
        { locale: vn.locale, name: vn.name }
      end,
      authorship:      scientific_name_authorship,
      created_at:      created_at,
      species_group:   species_group,
      taxonomic_rank:  taxonomic_rank,
      genus:           genus,

      valid_name:      valid_name,

      kingdom:         kingdom,
      phylum:          phylum_division,
      classis:         classis,
      published_on:    created_at,
      approved:        approved
    }.to_json
  end

  # Returns the kingdom of a species
  def kingdom
    kingdom = nil
    unless self.taxonomy.nil?
      taxonomy = self.taxonomy
      taxonomy = taxonomy.parent while taxonomy.level != 'Kingdom'
      kingdom = taxonomy.name
    end
    kingdom
  end

  def phylum_division
    pd = nil
    unless self.taxonomy.nil?
      taxonomy = self.taxonomy
      while taxonomy.level != 'Phylum' and taxonomy.level != 'Division' do
        taxonomy = taxonomy.parent
        return '' if taxonomy.level == 'Kingdom'
      end
      pd = taxonomy.name
    end
    pd
  end

  def classis
    clazz = nil
    unless self.taxonomy.nil?
      taxonomy = self.taxonomy
      while taxonomy.level != 'Class' do
        taxonomy = taxonomy.parent
        return '' if taxonomy.level == 'Kingdom'
      end
      clazz = taxonomy.name
    end
    clazz
  end

  def self.search(params)
    tire.search :load => true, :page => params[:page], :per_page => 20 do

      species_filter = []
      species_filter << { :term => { :species_group => params[:species_group] } } if params[:species_group].present?
      species_filter << { :term => { :taxonomic_rank => params[:taxonomic_rank] } } if params[:taxonomic_rank].present?
      species_filter << { :term => { :kingdom => params[:kingdom] } } if params[:kingdom].present?
      species_filter << { :term => { :phylum => params[:phylum] } } if params[:phylum].present?
      species_filter << { :term => { :classis => params[:classis] } } if params[:classis].present?

      query do
        boolean do
          should   { string 'binomial_name:' + params[:query].to_s }
          should   { string 'scientific_name:' + params[:query].to_s }
          # should     { string 'taxonomic_rank:Species'}
          # must_not { string 'published:0' }
        end
      end if params[:query].present?

      # query { string params[:query], :default_operator => "AND"} if params[:query].present?

      highlight :binomial_name
      # highlight :name, :options => { :tag => '<strong class="highlight">' }

      # filter :term, :author => params[:author] if params[:author].present?
      filter :term, :species_group => params[:species_group] if params[:species_group].present?
      filter :term, :taxonomic_rank => params[:taxonomic_rank] if params[:taxonomic_rank].present?

      filter :term, :kingdom => params[:kingdom] if params[:kingdom].present?
      filter :term, :phylum => params[:phylum] if params[:phylum].present?
      filter :term, :classis => params[:classis] if params[:classis].present?

      # sort { by :binomial_name, "asc" } # if params[:query].blank?


      facet 'kingdom' do
        terms :kingdom
        facet_filter :and, species_filter  unless species_filter.empty?
      end

      facet 'phylum' do
        terms :phylum
        facet_filter :and, species_filter  unless species_filter.empty?
      end

      facet 'classis' do
        terms :classis
        facet_filter :and, species_filter  unless species_filter.empty?
      end

      facet 'species_group' do
        terms :species_group, :size => 15
        facet_filter :and, species_filter  unless species_filter.empty?
      end

      facet 'taxonomic_rank' do
        terms :taxonomic_rank, :size => 15
        facet_filter :and, species_filter  unless species_filter.empty?
      end

      facet 'genus' do
        terms :genus, :order => 'term'
        # :all_terms => true,
        facet_filter :and, species_filter  unless species_filter.empty?
      end

      facet 'valid_name' do
        terms :valid_name, :size => 2
        # facet_filter :and, species_filter
        facet_filter :and, species_filter  unless species_filter.empty?
      end

      facet 'timeline' do
        date :created_at, :interval => 'year'
        # facet_filter :and, species_filter
        facet_filter :and, species_filter  unless species_filter.empty?
      end
    end
  end

end
