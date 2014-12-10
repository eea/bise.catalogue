class ArticlesController < ApplicationController
  inherit_resources

  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!
  has_scope :approved, type: :boolean, default: false

  after_filter :notify_created_content, only: :create
  after_filter :notify_updated_content, only: :update

  def create
    @article = Article.new(permitted_params[:article])
    @article.creator = current_user
    create!
  end

  def update
    @article = Article.find(params[:id])
    @article.modifier = current_user
    update!
  end

  def approve_multiple
    respond_to do |format|
      format.html { redirect_to articles_path, alert: "Please, select at least one article!" }
    end if params[:article_ids].nil?

    approved = Hash.new
    @articles = Article.find(params[:article_ids])
    @articles.each do |article|
      approved[!article.approved]=approved[!article.approved].to_i+1 || 1
      article.update_attributes approved:!article.approved
      article.update_index
    end
    sleep 1
    respond_to do |format|
      format.html { redirect_to articles_url(approved: approved[true].to_i<approved[false].to_i) }
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

  def notify_created_content
    ContentMailer.content_created_email(current_user, @article).deliver
  end

  def notify_updated_content
    ContentMailer.content_updated_email(current_user, @article).deliver
  end

  protected

  def collection
    @articles ||= end_of_association_chain.search(params)
  end

end
