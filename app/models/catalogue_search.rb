# class to store all searches performed from catalogue-client
class CatalogueSearch < ActiveRecord::Base

  validates_presence_of :query
  before_save :sanitize_query

  def initialize(args)
    args[:indexes] = args[:indexes].join(',')
    args[:countries] = args[:countries].join(',') if args[:countries].present?
    args[:languages] = args[:languages].join(',') if args[:languages].present?
    super
    @params = args
    # @filters ||= []
    @categories = args[:indexes]
    if args[:published_on].present?
      self.start_date = DateTime.new(args[:published_on].to_i, 1, 1)
      self.end_date = DateTime.new(args[:published_on].to_i, 12, 31)
    end
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

  def es_indexes
    if indexes.present?
      indexes.split(',').map do |category|
        "catalogue_#{Rails.env}_#{category}"
      end
    else
      indexes
    end
  end

  def start_page
    page == 1 ? 0 : (page - 1) * per
  end

  private

  def sanitize_query
    @query = Sanitize.clean(query)
  end
end
