class ArticlesController < ApplicationController
  inherit_resources

  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!
  has_scope :approved, type: :boolean

  def create
    resource = Article.new(permitted_params[:article])
    resource.creator = current_user
    create!
  end

  def update
    @article = Article.find(params[:id])
    @article.modifier = current_user
    update!
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

  def permitted_params
    params[:article][:country_ids] ||= [] if params[:article].present?
    params.permit(article: [
      :id, :site_id, :title, :english_title, :author, :source_url, :content,
      :biographical_region, :published_on, :published, :approved, :approved_at,
      tag_list: [], target_list: [], action_list: [],
      country_ids: [], language_ids: []
    ])
  end

  protected

  def collection
    @articles ||= end_of_association_chain.search(params)
  end

end
