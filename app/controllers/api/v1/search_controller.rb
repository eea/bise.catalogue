require 'sanitize'

module Api
  module V1
    # Search service controller for API v1
    class SearchController < ApplicationController
      respond_to :json
      after_filter :set_access_control_headers

      def bise_search
        search = CatalogueSearch.new(search_params)

        @geoip ||= GeoIP.new("#{Rails.root}/db/GeoIP.dat")
        search.queried_from_ip = request.remote_ip
        location = @geoip.country(request.remote_ip)[:country_name]
        search.location = location if location != 0


        if search.save!
          respond_with BiseSearchExhibit.new(search).process
        else
          respond_with {}
        end
      end

      def advanced_search
        search = CatalogueSearch.new(search_params)

        @geoip ||= GeoIP.new("#{Rails.root}/db/GeoIP.dat")
        search.queried_from_ip = request.remote_ip
        location = @geoip.country(request.remote_ip)[:country_name]
        search.location = location if location != 0

        if search.save!
          respond_with AdvancedSearchExhibit.new(search).process
        else
          respond_with {}
        end
      end

      private

      def search_params
        params.permit(:query, :page, :per, :site,
                      :countries, :languages, :strategytarget,
                      :source_db, :biographical_region, :published_on,
                      :species_group, :taxonomic_rank, :genus,
                      indexes: [])
      end

      def set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Request-Method'] = '*'
      end
    end
  end
end
