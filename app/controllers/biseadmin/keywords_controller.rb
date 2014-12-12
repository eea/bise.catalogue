# Keyword controller
class Biseadmin::KeywordsController < ApplicationController

  before_filter :authenticate_user!

  def edit
    authorize! :admin, Keyword
    @keyword = Keyword.find(params[:id])
  end

  def create
    @keyword = Keyword.new(params[:keyword])
    respond_to do |format|
      if @keyword.save
        format.html { redirect_to biseadmin_keyword_container_path(@keyword.keyword_container), notice: 'Keyword was successfully created.' }
        format.json { render json: @keyword, status: :created, location: @keyword }
      else
        format.html { render action: biseadmin_keyword_container_path(@keyword.keyword_container) }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @keyword = Keyword.find(params[:id])

    respond_to do |format|
      if @keyword.update_attributes(params[:keyword])
        format.html { redirect_to biseadmin_keyword_container_path(@keyword.keyword_container), notice: 'Keyword was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @keyword = Keyword.find(params[:id])
    path = biseadmin_keyword_container_path(@keyword.keyword_container)
    @keyword.destroy

    respond_to do |format|
      format.html { redirect_to path }
      format.json { head :no_content }
    end
  end
end
