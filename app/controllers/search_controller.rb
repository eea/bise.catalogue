class SearchController < ApplicationController
  layout "public"

  def index
    @search = CatalogueSearch.new(search_params)
    @rows = AdvancedSearch.new(@search).process
    respond_to do |format|
      format.html
      format.json { render json: @rows }
    end
  end

  def search_params
    params.permit(:format, :query, :page, :per, :site,
                  :countries, :languages, :strategytarget,
                  :source_db, :biographical_region, :published_on,
                  :species_group, :taxonomic_rank, :genus,
                  indexes: [])
  end
end
