class ThemesController < ApplicationController

  # GET /themes.json
  def index
    @themes = Theme.all
    # @themes = Theme.all.collect do |theme|
    #     {
    #         :key => 'f' + theme.id.to_s,
    #         :title => theme.title,
    #         :folder => true,
    #         :children => theme.concepts.order('lower(title)').collect do |c|
    #             { :key => c.id, :title => c.title }
    #         end
    #     }
    # end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @themes }
    end
  end


  # GET /themes/1
  # GET /themes/1.json
  # def show
  #   @theme = Theme.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @theme }
  #   end
  # end

  # GET /themes/new
  # GET /themes/new.json
  # def new
  #   @theme = Theme.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @theme }
  #   end
  # end

  # GET /themes/1/edit
  # def edit
  #   @theme = Theme.find(params[:id])
  # end

  # POST /themes
  # POST /themes.json
  # def create
  #   @theme = Theme.new(params[:theme])

  #   respond_to do |format|
  #     if @theme.save
  #       format.html { redirect_to @theme, notice: 'Theme was successfully created.' }
  #       format.json { render json: @theme, status: :created, location: @theme }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @theme.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /themes/1
  # PUT /themes/1.json
  # def update
  #   @theme = Theme.find(params[:id])

  #   respond_to do |format|
  #     if @theme.update_attributes(params[:theme])
  #       format.html { redirect_to @theme, notice: 'Theme was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @theme.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /themes/1
  # DELETE /themes/1.json
  # def destroy
  #   @theme = Theme.find(params[:id])
  #   @theme.destroy

  #   respond_to do |format|
  #     format.html { redirect_to themes_url }
  #     format.json { head :no_content }
  #   end
  # end

end
