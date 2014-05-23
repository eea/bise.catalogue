require 'delegate'

# Exhibit to wrap search model and allow search
# only in bise site
class BiseSearchExhibit < SimpleDelegator

  def initialize(model)
    super(model)
    @search_type = 'BISE'
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
    a << { term: { 'site.name' => 'BISE' } }
    a << { term: { source_db: source_db } } if source_db.present?
    a << { term: { 'countries.name' => countries } } if countries.present?
    a << { term: { 'languages.name' => languages } } if languages.present?
    a << { term: { biographical_region: biographical_region } } if biographical_region.present?
    a << { range: { published_on: { gte: start_date , lt: end_date } } } if start_date.present?
    a << { term: { 'targets.title' => strategytarget } } if strategytarget.present?
    a
  end

  def process
    q = self.query
    source_db = self.source_db
    countries = self.countries
    languages = self.languages
    biogeo    = self.biographical_region
    date_init = self.start_date
    date_end  = self.end_date
    target    = self.strategytarget

    search_filter = self.search_filter
    indexes = self.es_indexes

    rows = Tire.search indexes, load: false, from: self.start_page, size: self.per do
      query do
        boolean do
          should   { string 'site.name: BISE' }
          should   { string 'title:'                     + q }
          should   { string 'english_title:'             + q }
          should   { string 'description:'               + q }
          should   { string 'content:'                   + q }
          should   { string 'attachment:'                + q }

          should   { string 'ngram_author:'              + q }

          should   { string 'countries.ngram_name:'      + q }
          should   { string 'languages.ngram_name:'      + q }

          should   { string 'tags.ngram_name:'           + q }
          should   { string 'biograhical_region_ngram:' + q }

          should   { string 'name:'                      + q }
          should   { string 'biogeo_regions.name:'       + q }
          should   { string 'biogeo_regions.code:'       + q }
        end
      end

      filter :bool, must: { term: { approved: true } }
      filter :term, 'site.name' => 'BISE'
      filter :term, source_db: source_db unless source_db.nil?
      filter :term, 'countries.name' => countries unless countries.nil?
      filter :term, 'languages.name' => languages unless languages.nil?
      filter :term, biographical_region: biogeo unless biogeo.nil?
      filter :range, published_on: { gte: date_init, lt: date_end } unless date_init.nil?
      filter :term, 'targets.title.exact' => target unless target.nil?

      highlight attachment: { number_of_fragments: 2 }

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

      facet 'published_on' do
        date :published_on, interval: 'year'
        facet_filter :and, search_filter unless search_filter.empty?
      end

      facet 'strategytarget' do
        terms 'targets.title.exact'
        facet_filter :and, search_filter unless search_filter.empty?
      end
    end
    extract_response rows
  end

end
