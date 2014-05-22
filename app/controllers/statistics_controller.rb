class StatisticsController < ApplicationController
  def index
    @searches = CatalogueSearch.all.order('created_at DESC')
                               .paginate(page: params[:page], per_page: 10)
  end
end
