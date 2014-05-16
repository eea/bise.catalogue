require 'sanitize'

module Api
  module V1
    # Search service controller for API v1
    class SearchController < ApplicationController
      respond_to :json
      after_filter :set_access_control_headers

      def bise_search
        search = Search.new(params).save_query
        respond_with BiseSearchExhibit.new(search).process
      end

      def advanced_search
        search = Search.new(params).save_query
        respond_with AdvancedSearchExhibit.new(search).process
      end

      private

      def set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Request-Method'] = '*'
      end
    end
  end
end
