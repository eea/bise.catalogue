class ProtectedAreasController < ApplicationController

  before_filter :authenticate_user!

  # GET /protected_areas
  # GET /protected_areas.json
  def index
    @protected_areas = ProtectedArea.search(params)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @protected_areas }
    end
  end

  # GET /protected_areas/1
  # GET /protected_areas/1.json
  def show
    @protected_area = ProtectedArea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @protected_area }
    end
  end

end
