class SpeciesController < ApplicationController

  before_filter :authenticate_user!

  # GET /species
  # GET /species.json
  def index
    @species = Species.search(params)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @species }
    end
  end

  # GET /species/1
  # GET /species/1.json
  def show
    @species = Species.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @species }
    end
  end

end
