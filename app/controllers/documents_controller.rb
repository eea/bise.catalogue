class DocumentsController < ApplicationController

  before_filter :authenticate_user!

  def index
    if params[:format] == 'xls'
      params[:per_page] = 1000
      response.headers["ContentType"]="text/xml"
      # response.headers["ContentType"]="application/vnd.ms-excel"
      response.headers["Content-Disposition"]="attachment"
    end
    @documents = Document.search(params)

    respond_to do |format|
      format.html
      # format.json { render json: @documents }
      format.xls
    end
  end

  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @document }
    end
  end

  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @document }
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def create
    @document = Document.new(params[:document])
    unless params[:tags].blank?
      tags = params[:tags]
      @document.tag_list = tags
    end

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, :notice => 'Document was successfully created.' }
        format.json { render :json => @document, :status => :created, :location => @document }
        format.js   { render :action => "success" }
      else
        format.html { render :action => "new" }
        format.json { render :json => @document.errors, :status => :unprocessable_entity }
        format.js   { render :action => "failure"}
      end
    end
  end

  def update
    @document = Document.find(params[:id])
    unless params[:tags].blank?
      tags = params[:tags]
      @document.tag_list = tags
    end

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, :notice => 'Document was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render :action => "edit" }
        format.json { render :json => @document.errors, :status => :unprocessable_entity }
        format.js   { render :action => "failure"}
      end
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  def approve_multiple
    if (params[:document_ids].nil?)
      respond_to do |format|
        format.html { redirect_to documents_path, alert: "Please, select at least one document!" }
      end
      return
    end

    @documents = Document.find(params[:document_ids])
    @documents.each do |document|
      document.approved = !document.approved
      document.save!
    end
    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

end
