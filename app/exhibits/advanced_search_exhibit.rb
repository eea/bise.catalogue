require 'delegate'

# Exhibit to wrap search model and allow search
# only in bise site
class AdvancedSearchExhibit < SimpleDelegator

  def initialize(model)
    super(model)
    @search_type = 'Advanced'
    save!
  end

  def to_model
    __getobj__
  end

  def class
    __getobj__.class
  end

  def search_filter
    a = []
    a << { term: { approved: true } }
    a << { term: { 'site.name' => site } } if site.present?
    a << { term: { source_db: source_db } } if source_db.present?
    # a << { term: { author: @params[:author] }} if @params[:author].present?
    a << { term: { 'countries.name' => countries } } if countries.present?
    a << { term: { 'languages.name' => languages } } if languages.present?
    a << { term: { biographical_region: biographical_region } } if biographical_region.present?
    a << { range: { published_on: { gte: start_date , lt: end_date } } } if start_date.present?

    # EUNIS attrs
    a << { term: { species_group: species_group } } if species_group.present?
    a << { term: { taxonomic_rank: taxonomic_rank } } if taxonomic_rank.present?
    a << { term: { genus: genus } } if genus.present?
    a
  end

  def process
    q = self.query
    site      = self.site
    source_db = self.source_db
    countries = self.countries
    languages = self.languages
    biogeo    = self.biographical_region
    date_init = self.start_date
    date_end  = self.end_date
    search_filter = self.search_filter
    indexes = self.es_indexes

    species_group  = self.species_group
    taxonomic_rank = self.taxonomic_rank
    genus          = self.genus

    rows = Tire.search indexes, load: false, from: self.start_page, size: self.per do
      query do
        boolean do
          should   { string 'site.ngram_name:'           + q }

          should   { string 'title:'                     + q }
          should   { string 'english_title:'             + q }
          should   { string 'description:'               + q }
          should   { string 'content:'                   + q }
          should   { string 'attachment:'                + q }

          should   { string 'ngram_author:'              + q }

          should   { string 'countries.ngram_name:'      + q }
          should   { string 'languages.ngram_name:'      + q }

          should   { string 'tags.ngram_name:'           + q }
          should   { string 'biographical_region_ngram:' + q }

          should   { string 'name:'                      + q }
          should   { string 'biogeo_regions.name:'       + q }
          should   { string 'biogeo_regions.code:'       + q }

          # Species scientifi name
          should   { string 'scientific_name:'           + q }
          should   { string 'vernacular_names.name:'     + q }
          should   { string 'authorship:'                + q }
          should   { string 'species_group:'             + q }
          should   { string 'taxonomic_rank:'            + q }
          should   { string 'genus:'                     + q }
          should   { string 'kingdom:'                   + q }
          should   { string 'phylum:'                    + q }
          should   { string 'classis:'                   + q }
          should   { string 'synonyms.binomial_name:'    + q }
          should   { string 'synonyms.scientific_name:'  + q }
          should   { string 'protected_areas.code:'      + q }
          should   { string 'protected_areas.name:'      + q }
          should   { string 'habitats.name:'             + q }
          should   { string 'habitats.code:'             + q }

        end
      end

      filter :bool, must: { term: { approved: true } }
      filter :term, 'site.name' => site unless site.nil?
      filter :term, source_db: source_db unless source_db.nil?
      filter :term, 'countries.name' => countries unless countries.nil?
      filter :term, 'languages.name' => languages unless languages.nil?
      filter :term, biographical_region: biogeo unless biogeo.nil?
      filter :range, published_on: { gte: date_init, lt: date_end } unless date_init.nil?

      highlight attachment: { number_of_fragments: 2 }

      facet 'site' do
        terms 'site.name'
        facet_filter :and, search_filter unless search_filter.empty?
      end

      facet 'source_db' do
        terms :source_db
        facet_filter :and, search_filter unless search_filter.empty?
      end

      facet 'countries' do
        terms 'countries.name', size: 60
        facet_filter :and, search_filter unless search_filter.empty?
      end

      facet 'biographical_region' do
        terms :biographical_region
        facet_filter :and, search_filter unless search_filter.empty?
      end

      facet 'languages' do
        terms 'languages.name'
        facet_filter :and, search_filter unless search_filter.empty?
      end

      facet 'species_group' do
        terms :species_group, size: 15
        facet_filter :and, search_filter  unless search_filter.empty?
      end

      facet 'taxonomic_rank' do
        terms :taxonomic_rank, size: 15
        facet_filter :and, search_filter  unless search_filter.empty?
      end

      facet 'genus' do
        terms :genus, order: 'term'
        facet_filter :and, search_filter  unless search_filter.empty?
      end

      facet 'published_on' do
        date :published_on, interval: 'year'
        facet_filter :and, search_filter unless search_filter.empty?
      end
    end
    extract_response rows
  end

end
