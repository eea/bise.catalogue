
# To consume tags from 3rd Party systems
module Api
  module V1
    class TagController < ApplicationController
      respond_to :json

      def all_tags
        @categories = KeywordContainer.all
      end

      def all_targets
        @targets = Target.all
      end
    end
  end
end