require 'sanitize'
require "benchmark"


module Api
  module V1
    # Search service controller for API v1
    class SearchController < ApplicationController
      respond_to :json
      after_filter :set_access_control_headers

      def bise_search
        search = CatalogueSearch.new(search_params)
        if search.save!
          respond_with BiseSearchExhibit.new(search).process
        else
          respond_with {}
        end
      end

      def advanced_search
        # binding.remote_pry
        logger.warn { ":::::::::::: BENCHMARK :::::::::::::::" }
        time = Benchmark.measure do
          # (1..10000).each { |i| i }
          search = CatalogueSearch.new(search_params)
          response = AdvancedSearchExhibit.new(search).process
        end
        logger.warn { ":: TIME => #{time}" }

        beginning_time = Time.now
        search = CatalogueSearch.new(search_params)
        if search.save!
          respond_with AdvancedSearchExhibit.new(search).process
          end_time = Time.now
          logger.warn { "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::" }
          logger.warn { ":: Time elapsed #{(end_time - beginning_time)*1000} milliseconds" }
          logger.warn { "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::" }
        else
          respond_with {}
        end
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
