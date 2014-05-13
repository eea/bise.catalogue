# Keyword controller
class Biseadmin::KeywordContainersController < ApplicationController

  before_filter :authenticate_user!

  def index
    # @keywords = Keyword.all
    @keyword_containers = KeywordContainer.all

    respond_to do |format|
      format.html
      format.json { render json: @keyword_containers }
    end
  end

  def new
    @keyword_container = KeywordContainer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keyword_container }
    end
  end

  def show
    @keyword_container = KeywordContainer.find(params[:id])
  end

  def edit
    @keyword_container = KeywordContainer.find(params[:id])
  end

  def create
    @keyword_container = KeywordContainer.new(params[:keyword_container])

    respond_to do |format|
      if @keyword_container.save
        format.html { redirect_to biseadmin_keyword_container_path(@keyword), notice: 'KeywordContainer was successfully created.' }
        format.json { render json: @keyword_container, status: :created, location: @keyword_container }
      else
        format.html { render action: "new" }
        format.json { render json: @keyword_container.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @keyword_container = KeywordContainer.find(params[:id])

    respond_to do |format|
      if @keyword_container.update_attributes(params[:keyword_container])
        format.html { redirect_to biseadmin_keyword_containers_path, notice: 'KeywordContainer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @keyword_container.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @keyword_container = KeywordContainer.find(params[:id])
    @keyword_container.destroy

    respond_to do |format|
      format.html { redirect_to biseadmin_keyword_containers_url }
      format.json { head :no_content }
    end
  end
end
