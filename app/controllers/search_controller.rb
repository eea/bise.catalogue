class SearchController < ApplicationController

    layout "embedded"

    def index
        puts ":: search#index"
        q = params[:query]
        q = nil if q == ''
        # binding.pry

        if !q.nil?
            @rows = Tire.search %w(catalogue_production_articles catalogue_production_documents catalogue_production_species), :laod => true, :page => params[:page], :per_page => 30 do
                query do
                    boolean do
                        should   { string 'title:' + q } # if not q.nil?
                        # should   { string 'content:' + params[:query].to_s }
                        # must_not { string 'published:0' }
                    end
                end
            end
        else
            @rows = Tire::Results::Collection.new
        end



        # @articles = Article.first
        respond_to do |format|
            format.html
            format.json { render :json => @rows }
        end
    end

end
