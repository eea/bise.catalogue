class GraphsController < ApplicationController
  inherit_resources

  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!
  has_scope :approved, type: :boolean

  after_filter :notify_created_content, only: :create
  after_filter :notify_updated_content, only: :update

  def create
    @graph = Graph.new(permitted_params[:graph])
    @graph.update_attribute(:description, params[:graph][:description])
    @graph.creator = current_user
    create!
  end

  def update
    @graph = Graph.find(params[:id])
    @graph.modifier = current_user
    @graph.update_attribute(:description, params[:graph][:description])
    update!
  end

  def approve_multiple
    return respond_to do |format|
      format.html { redirect_to graphs_path, alert: 'Please, select at least one graph!' }
    end if params[:graph_ids].nil?

    approved = Hash.new
    @graphs = Graph.find(params[:graph_ids])
    @graphs.each do |graph|
      approved[!graph.approved]=approved[!graph.approved].to_i+1 || 1
      graph.update_attributes approved:!graph.approved
      graph.update_index
    end
    sleep 1
    respond_to do |format|
      format.html { redirect_to graphs_url(approved: approved[true].to_i<approved[false].to_i) }
      format.json { head :no_content }
    end
  end

  def permitted_params
    params[:graph][:country_ids] ||= [] if params[:graph].present?
    params.permit(graph: [
      :id, :site_id, :title, :english_title, :author, :url, :source_url,
      :content, :biographical_region, :published_on, :published, :approved,
      :approved_at, :is_part_of, :is_replaced_by, :has_part, :thumbnail_link,
      :embed_code, :thumb,

      tag_list: [], target_list: [], action_list: [], country_ids: [],
      language_ids: []
    ])
  end

  def notify_created_content
    ContentMailer.content_created_email(current_user, @graph).deliver
  end

  def notify_updated_content
    ContentMailer.content_updated_email(current_user, @graph).deliver
  end

  protected

  def collection
    @graphs ||= end_of_association_chain.search(params)
  end

end
