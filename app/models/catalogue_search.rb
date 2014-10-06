# class to store all searches performed from catalogue-client
class CatalogueSearch < ActiveRecord::Base
  include Sidekiq::Delay

  before_save :sanitize_query
  # after_create :geolocate_search
  # paginates_per 10

  def initialize(args)
    args[:indexes] = args[:indexes].join(',') if args[:indexes].present?
    super
    self.query = '*' unless args[:query].present?
    if args[:published_on].present?
      self.start_date = DateTime.new(args[:published_on].to_i, 1, 1)
      self.end_date = DateTime.new(args[:published_on].to_i, 12, 31)
    end
    self.page ||= 1
    self.per ||= 10
  end

  # def extract_response(rows)
  #   if rows.nil? || rows.results.nil?
  #     { total: 0, results: [], facets: [] }
  #   else
  #     { total: rows.results.total,
  #       results: rows.results,
  #       facets: rows.results.facets }
  #   end
  # end

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
    return 0 if page.nil?
    page == 1 ? 0 : (page - 1) * per
  end

  private

  def sanitize_query
    @query = Sanitize.clean(query)
  end

  def geolocate_search
    @geoip ||= GeoIP.new("#{Rails.root}/db/GeoIP.dat")
    # self.queried_from_ip = request.remote_ip
    loc = @geoip.country(request.remote_ip)[:country_name]
    self.location = loc if loc != 0
    save!
  end

end
