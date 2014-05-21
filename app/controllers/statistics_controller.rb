class StatisticsController < ApplicationController
  def index
    @searches = CatalogueSearch.all.paginate(page: params[:page], per_page: 10)
  end
end
