class Search
  include Tire::Model::Persistence

  validates_presence_of :query

  property :queried_at  , type: 'date'
  property :queried_from
  property :query       , analyzer: 'snowball'

  property :categories  , default: [], analyzer: 'keyword'

  property :from_date   , type: 'date'
  property :to_date     , type: 'date'

  property :page        , type: 'integer'
  property :per         , type: 'integer'

  property :filters     , default: []

  def initialize(args)
    @params = args
    @filters ||= []
    @categories = args[:indexes]
    if args[:published_on].present?
      @from_date = DateTime.new(args[:published_on].to_i, 1, 1)
      @to_date = DateTime.new(args[:published_on].to_i, 12, 31)
    end
  end

  def save_query
    self.query = current_query
    self.queried_at = DateTime.now
    save
    self
  end

  def extract_response(rows)
    if rows.nil? || rows.results.nil?
      { total: 0, results: [], facets: [] }
    else
      { total: rows.results.total,
        results: rows.results,
        facets: rows.results.facets }
    end
  end

  def current_query
    @params[:query].nil? ? nil : Sanitize.clean(@params[:query])
  end

  def es_indexes
    if @params[:indexes].present?
      @params[:indexes].map do |category|
        "catalogue_#{Rails.env}_#{category}"
      end
    else
      @params[:indexes]
    end
  end

  def page
    @params[:page].to_i || 1
  end

  def per
    @params[:per] || 10
  end

  def site
    @params[:site]
  end

  def source_db
    @params[:source_db]
  end

  def countries
    @params[:countries].present? ? @params[:countries].split(/\//) : nil
  end

  def languages
    @params[:languages].present? ? @params[:languages].split(/\//) : nil
  end

  def bioregion
    @params[:biographical_region]
  end

  def published_on
    @params[:published_on]
  end

  def start_page
    self.page == 1 ? 0 : (self.page - 1) * self.per
  end


  # EUNIS params

  def kingdom
    @params[:kingdom]
  end

  def phylum
    @params[:phylum]
  end

  def classis
    @params[:classis]
  end

  def species_group
    @params[:species_group]
  end

  def taxonomic_rank
    @params[:taxonomic_rank]
  end

  def genus
    @params[:genus]
  end

end
