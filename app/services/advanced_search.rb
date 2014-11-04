class AdvancedSearch

  def initialize(search)
    search.attributes.each_pair{ |k, v| instance_variable_set( "@#{k}", v) }
    @load = (@format.eql?(:json)) ? false : true
  end

  # Allows :json format for API
  def process(format)
    (format.eql?(:json)) ? extract_json(elastic_query) : elastic_query
  end

  def filters
    a = []
    a << { term: { approved: true } }
    a << { term: { 'site.name' => @site } } if @site.present?
    a << { term: { source_db: @source_db } } if @source_db.present?
    a << { term: { 'countries.name' => @countries } } if @countries.present?
    a << { term: { 'languages.name' => @languages } } if @languages.present?
    a << { term: { biographical_region: @biographical_region } } if @biographical_region.present?
    a << { range:{ published_on: { gte: @start_date , lt: @end_date } } } if @start_date.present?
    a << { term: { 'targets.title.exact' => @strategytarget } } if @strategytarget.present?

    # EUNIS attrs
    a << { term: { species_group: @species_group } } if @species_group.present?
    a << { term: { taxonomic_rank: @taxonomic_rank } } if @taxonomic_rank.present?
    a << { term: { genus: @genus } } if @genus.present?
    a
  end

  def elastic_query(options = {})
    q              = @query
    site           = @site
    source_db      = @source_db
    countries      = @countries
    languages      = @languages
    biogeo         = @biographical_region
    date_init      = @start_date
    date_end       = @end_date
    target         = @strategytarget

    search_filter  = filters
    indexes        = es_indexes

    species_group  = @species_group
    taxonomic_rank = @taxonomic_rank
    genus          = @genus

    rows = Tire.search indexes, load: @load, from: start_page, size: @per do
      query do
        boolean do
          should   { string 'title:'                     + q }
          should   { string 'english_title:'             + q }
          should   { string 'description:'               + q }
          should   { string 'content:'                   + q }
          should   { string 'attachment:'                + q }

          should   { string 'authors.name:'              + q }

          should   { string 'countries.ngram_name:'      + q }
          should   { string 'languages.ngram_name:'      + q }

          should   { string 'tags.name:'                 + q }

          # should   { string 'name:'                      + q }
          should   { string 'biogeo_regions.name:'       + q }
          should   { string 'biogeo_regions.code:'       + q }

          # Species scientifi name
          should   { string 'scientific_name:'           + q }
          should   { string 'vernacular_names.name:'     + q }
          should   { string 'authorship:'                + q }
          should   { string 'metadata:'                  + q }
          should   { string 'synonyms.binomial_name:'    + q }
          should   { string 'synonyms.scientific_name:'  + q }
        end
      end

      filter :bool, must: { term: { approved: true } }
      filter :term, 'site.name' => site unless site.nil?
      filter :term, source_db: source_db unless source_db.nil?
      filter :term, 'countries.name' => countries unless countries.nil?
      filter :term, 'languages.name' => languages unless languages.nil?
      filter :term, biographical_region: biogeo unless biogeo.nil?
      filter :range, published_on: { gte: date_init, lt: date_end } unless date_init.nil?
      filter :term, 'targets.title.exact' => target unless target.nil?

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

      facet 'strategytarget' do
        terms 'targets.title.exact'
        facet_filter :and, search_filter unless search_filter.empty?
      end
    end
    rows
  end

private

  def es_indexes
    @indexes.split(',').map do |category|
      "catalogue_#{Rails.env}_#{category}"
    end unless @indexes.nil?
  end

  def start_page
    return 0 if @page.nil?
    @page == 1 ? 0 : (@page - 1) * @per
  end

  def extract_json(rows)
    if rows.nil? || rows.results.nil?
      { total: 0, results: [], facets: [] }
    else
      { total: rows.results.total,
        results: rows.results,
        facets: rows.results.facets }
    end
  end

end