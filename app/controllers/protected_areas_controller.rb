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

  # GET /protected_areas/new
  # GET /protected_areas/new.json
  def new
    @protected_area = ProtectedArea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @protected_area }
    end
  end

  # GET /protected_areas/1/edit
  def edit
    @protected_area = ProtectedArea.find(params[:id])
  end

  # POST /protected_areas
  # POST /protected_areas.json
  def create
    @protected_area = ProtectedArea.new(params[:protected_area])

    respond_to do |format|
      if @protected_area.save
        format.html { redirect_to @protected_area, notice: 'Protected area was successfully created.' }
        format.json { render json: @protected_area, status: :created, location: @protected_area }
      else
        format.html { render action: "new" }
        format.json { render json: @protected_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /protected_areas/1
  # PUT /protected_areas/1.json
  def update
    @protected_area = ProtectedArea.find(params[:id])

    respond_to do |format|
      if @protected_area.update_attributes(params[:protected_area])
        format.html { redirect_to @protected_area, notice: 'Protected area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @protected_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /protected_areas/1
  # DELETE /protected_areas/1.json
  def destroy
    @protected_area = ProtectedArea.find(params[:id])
    @protected_area.destroy

    respond_to do |format|
      format.html { redirect_to protected_areas_url }
      format.json { head :no_content }
    end
  end
end
