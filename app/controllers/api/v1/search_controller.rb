require 'sanitize'
# require "benchmark"

module Api
  module V1
    # Search service controller for API v1
    class SearchController < ApplicationController
      respond_to :json
      after_filter :set_access_control_headers

      def bise_search
        search = CatalogueSearch.new(search_params)
        respond_with BiseSearch.new(search).process
      end

      def advanced_search
        @search = CatalogueSearch.new(search_params)
        respond_with AdvancedSearch.new(@search).process
      end

      private

      def search_params
        params.permit(:format, :query, :page, :per, :site,
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
