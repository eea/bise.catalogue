# class to store all searches performed from catalogue-client
class CatalogueSearch < ActiveRecord::Base
  validates_presence_of :query
  before_save :sanitize_query

  def initialize(args)
    logger.info '::::::::::::: CATALOGUE SEARCH :::::::::::::::::'
    logger.info args
    args[:indexes] = args[:indexes].join(',')
    super
    # @countries_list = args[:countries].join(',') if args[:countries].present?
    # @languages_list = args[:languages].join(',') if args[:languages].present?
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

  # def countries
  #   @countries_list.present? ? @countries_list.split(',') : nil
  # end

  # def languages
  #   @languages_list.present? ? @languages_list.split(',') : nil
  # end

  def es_indexes
    indexes.split(',').map do |category|
      "catalogue_#{Rails.env}_#{category}"
    end unless indexes.nil?
  end

  def start_page
    page == 1 ? 0 : (page - 1) * per
  end

  private

  def sanitize_query
    @query = Sanitize.clean(query)
  end
end