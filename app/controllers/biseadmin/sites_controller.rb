class Biseadmin::SitesController < ApplicationController

  before_filter :authenticate_user!

  def index
    authorize! :admin, Site
    @sites = Site.all

    respond_to do |format|
      format.html
      format.json { render json: @sites }
    end
  end

  def new
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    @site = Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.html { redirect_to biseadmin_sites_path, notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to biseadmin_sites_path, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    msg = (!@site.errors.empty?) ? @site.errors[:base].try(:first) : false
    respond_to do |format|
      format.html { redirect_to biseadmin_sites_url, alert: msg }
      format.json { head :no_content }
    end
  end
end
