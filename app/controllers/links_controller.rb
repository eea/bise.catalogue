class LinksController < ApplicationController
  inherit_resources

  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!
  has_scope :approved, type: :boolean

  after_filter :notify_created_content, only: :create
  after_filter :notify_updated_content, only: :update

  def create
    @link = Link.new(permitted_params[:link])
    @link.creator = current_user
    create!
  end

  def update
    @link = Link.find(params[:id])
    @link.modifier = current_user
    @link.update_attribute(:description, params[:link][:description])
    update!
  end

  def approve_multiple
    return respond_to do |format|
      format.html { redirect_to links_path, alert: 'Please, select at least one link!' }
    end if params[:link_ids].nil?

    approved = Hash.new
    @links = Link.find(params[:link_ids])
    @links.each do |link|
      approved[!link.approved]=approved[!link.approved].to_i+1 || 1
      link.update_attributes approved:!link.approved
      link.update_index
    end
    sleep 1
    respond_to do |format|
      format.html { redirect_to links_url(approved: approved[true].to_i<approved[false].to_i) }
      format.json { head :no_content }
    end
  end

  def permitted_params
    params[:link][:country_ids] ||= [] if params[:link].present?
    params.permit(link: [
      :id, :site_id, :title, :english_title, :author, :url, :source_url, :content,
      :biographical_region, :published_on, :published, :approved, :approved_at,
      tag_list: [], target_list: [], action_list: [],
      country_ids: [], language_ids: []
    ])
  end

  def notify_created_content
    ContentMailer.content_created_email(current_user, @link).deliver
  end

  def notify_updated_content
    ContentMailer.content_updated_email(current_user, @link).deliver
  end

  protected

  def collection
    @links ||= end_of_association_chain.search(params)
  end

end
