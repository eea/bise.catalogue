class SpeciesController < ApplicationController
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

  # GET /species/new
  # GET /species/new.json
  def new
    @species = Species.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @species }
    end
  end

  # GET /species/1/edit
  def edit
    @species = Species.find(params[:id])
  end

  # POST /species
  # POST /species.json
  def create
    @species = Species.new(params[:species])

    respond_to do |format|
      if @species.save
        format.html { redirect_to @species, notice: 'Specie was successfully created.' }
        format.json { render json: @species, status: :created, location: @species }
      else
        format.html { render action: "new" }
        format.json { render json: @species.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /species/1
  # PUT /species/1.json
  def update
    @species = Species.find(params[:id])

    respond_to do |format|
      if @species.update_attributes(params[:species])
        format.html { redirect_to @species, notice: 'Specie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @species.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /species/1
  # DELETE /species/1.json
  def destroy
    @species = Species.find(params[:id])
    @species.destroy

    respond_to do |format|
      format.html { redirect_to species_url }
      format.json { head :no_content }
    end
  end
end
