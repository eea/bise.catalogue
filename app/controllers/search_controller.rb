class SearchController < ApplicationController

    layout "embedded"

    def index
        puts ":: search#index"
        q = params[:query]
        q = nil if q == ''
        # binding.pry

        if !q.nil?
            @rows = Tire.search %w(catalogue_development_articles catalogue_development_documents) do
                query do
                    boolean do
                        should   { string 'title:' + q } # if not q.nil?
                        # should   { string 'content:' + params[:query].to_s }
                        # must_not { string 'published:0' }
                    end
                end
            end
        else
            @rows = nil
        end



        # @articles = Article.first
        respond_to do |format|
            format.html
            format.json { render :json => @rows }
        end
    end

end
