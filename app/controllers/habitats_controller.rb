class HabitatsController < ApplicationController

  before_filter :authenticate_user!

  # GET /habitats
  # GET /habitats.json
  def index
    # @habitats = Habitat.all
    @habitats = Habitat.search(params)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @habitats }
    end
  end

  # GET /habitats/1
  # GET /habitats/1.json
  def show
    @habitat = Habitat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @habitat }
    end
  end

end
