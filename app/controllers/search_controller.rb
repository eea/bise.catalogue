class SearchController < ApplicationController

  layout "embedded"

  def index
    puts ":: search#index"
    q = params[:query]
    q = nil if q == ''

    indexes = nil
    if Rails.env.production?
      indexes = %w(catalogue_production_articles catalogue_production_documents catalogue_production_species)
    elsif Rails.env.development?
      indexes = %w(catalogue_development_articles catalogue_development_documents catalogue_development_species)
    end

    if !q.nil?
      @rows = Tire.search indexes, :laod => true, :page => params[:page], :per_page => 30 do
        query do
          boolean do
            # Article & Documents titles
            should   { string 'title:' + q }

            # Species scientifi name
            should   { string 'scientific_name:' + q }

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
