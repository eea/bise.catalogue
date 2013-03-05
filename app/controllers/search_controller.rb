class SearchController < ApplicationController

    def index
        @articles = Article.first
        respond_to do |format|
            format.html
            format.json { render :json => @articles }
        end
    end

end
