class HabitatsController < ApplicationController
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

  # GET /habitats/new
  # GET /habitats/new.json
  def new
    @habitat = Habitat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @habitat }
    end
  end

  # GET /habitats/1/edit
  def edit
    @habitat = Habitat.find(params[:id])
  end

  # POST /habitats
  # POST /habitats.json
  def create
    @habitat = Habitat.new(params[:habitat])

    respond_to do |format|
      if @habitat.save
        format.html { redirect_to @habitat, notice: 'Habitat was successfully created.' }
        format.json { render json: @habitat, status: :created, location: @habitat }
      else
        format.html { render action: "new" }
        format.json { render json: @habitat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /habitats/1
  # PUT /habitats/1.json
  def update
    @habitat = Habitat.find(params[:id])

    respond_to do |format|
      if @habitat.update_attributes(params[:habitat])
        format.html { redirect_to @habitat, notice: 'Habitat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @habitat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habitats/1
  # DELETE /habitats/1.json
  def destroy
    @habitat = Habitat.find(params[:id])
    @habitat.destroy

    respond_to do |format|
      format.html { redirect_to habitats_url }
      format.json { head :no_content }
    end
  end
end
