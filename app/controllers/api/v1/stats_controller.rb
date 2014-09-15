class Api::V1::StatsController < ApplicationController

  skip_before_filter :protect_from_forgery
  respond_to :json

  after_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def index
    @tags = ::CatalogueSearch.where("query != '*'").group(:query)
      .order('count_id desc').limit(20).count('id')

    indexes = %w(articles documents links).map { |m| "catalogue_#{Rails.env}_#{m}" }
    search = Tire.search indexes, load: true, page: 1, per_page: 5 do
      # filter :bool, must: { term: { approved: true }}
      sort { by :published_on, 'desc' }
    end
    @last = search.results[0..4]

    @counts = {
      documents: Document.where(approved: true).size,
      webpages: Article.where(approved: true).size,
      links: Link.where(approved: true).size,
      sites: ProtectedArea.all.size,
      habitats: Habitat.all.size,
      species: Article.all.size
    }
    # @counts_per_country =

  end

end
