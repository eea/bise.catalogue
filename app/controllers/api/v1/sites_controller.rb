
module Api
  module V1
    # Search service controller for API v1
    class SitesController < ApplicationController
      respond_to :json
      after_filter :set_access_control_headers

      def show
        @site = Site.find(params[:id])
      end

      private

      def set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Request-Method'] = '*'
      end
    end
  end
end
