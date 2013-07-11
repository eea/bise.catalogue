class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.search(params )
    # @documents = Document.all

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @documents }
    # end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @targets = Target.all
    @countries = Country.all
    @languages = Language.all
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @targets = Target.all
    @countries = Country.all
    @languages = Language.all
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
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
        format.js   { render :action => "success"}
      else
        format.html { render :action => "new" }
        format.json { render :json => @document.errors, :status => :unprocessable_entity }
        format.js   { render :action => "failure"}
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update

    @document = Document.find(params[:id])

    unless params[:tags].blank?
      tags = params[:tags]
      @document.tag_list = tags
    end

    respond_to do |format|
      if @document.update_attributes(params[:document])
        puts ":: SAVE"
        format.html { redirect_to @document, :notice => 'Document was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        puts ":: ERROR"
        format.html { render :action => "edit" }
        format.json { render :json => @document.errors, :status => :unprocessable_entity }
        format.js   { render :action => "failure"}
        #{ render :json => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end
end
