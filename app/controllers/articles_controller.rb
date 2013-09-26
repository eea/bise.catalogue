class ArticlesController < ApplicationController

  before_filter :authenticate_user!

  def index
    @articles = Article.search(params)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @articles }
    end
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  def new
    @article = Article.new
    respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @article }
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params[:article])
    unless params[:tags].blank?
      tags = params[:tags]
      @article.tag_list = tags
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, :notice => 'Article was successfully created.' }
        format.json { render :json => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @article = Article.find(params[:id])
    unless params[:tags].blank?
      tags = params[:tags]
      @article.tag_list = tags
    end
    @article.update_attributes(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, :notice => 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  def approve_multiple
    if (params[:article_ids].nil?)
      respond_to do |format|
        format.html { redirect_to articles_path, alert: "Please, select at least one article!" }
      end
      return
    end

    @articles = Article.find(params[:article_ids])
    @articles.each do |article|
      article.approved = !article.approved
      article.save!
    end
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

end
