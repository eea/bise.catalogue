class HomeController < ApplicationController

  before_filter :authenticate_user!

  def index
    @catalogue_searches = CatalogueSearch.order('created_at DESC').limit(10)
  end

end
