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
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @countries = Country.all
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        puts ":: SAVE"
        format.html { redirect_to @document, :notice => 'Document was successfully created.' }
        format.json { render :json => @document, :status => :created, :location => @document }
        format.js           # { render :nothing => true, :status => :ok }
        # format.js { render :json => @document, :status => :ok, :location => @document }
      else
        puts ":: ERROR"
        format.html { render :action => "new" }
        format.json { render :json => @document.errors, :status => :unprocessable_entity }
        # format.js   { render :js => @document.errors }
        format.js   { render :action => "failure"}
        # format.js {
        #   render :partial => 'documents/errors', :locals => { :document => @document }
        # }
        # do
        #   render :update do |page|
        #     page.replace_html 'secondary_publication_table', :partial=>'publications/table'
        #   end
        # end
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update

    @document = Document.find(params[:id])

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
