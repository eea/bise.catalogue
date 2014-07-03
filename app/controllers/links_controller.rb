class LinksController < ApplicationController
  inherit_resources

  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!
  has_scope :approved, type: :boolean

  def approve_multiple
    return respond_to do |format|
      format.html { redirect_to links_path, alert: 'Please, select at least one link!' }
    end if params[:link_ids].nil?

    @links = Link.find(params[:link_ids])
    @links.each do |link|
      link.approved = !link.approved
      link.save!
    end
    respond_to do |format|
      format.html { redirect_to links_url }
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

  protected

  def collection
    @links ||= end_of_association_chain.search(params)
  end

end
