class IndicatorsController < ApplicationController
  inherit_resources

  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!
  has_scope :approved, type: :boolean

  after_filter :notify_created_content, only: :create
  after_filter :notify_updated_content, only: :update

  def create
    @indicator = Indicator.new(permitted_params[:indicator])
    @indicator.creator = current_user
    create!
  end

  def update
    @indicator = Indicator.find(params[:id])
    @indicator.modifier = current_user
    @indicator.update_attribute(:description, params[:indicator][:description])
    update!
  end

  def approve_multiple
    return respond_to do |format|
      format.html { redirect_to indicators_path, alert: 'Please, select at least one indicator!' }
    end if params[:indicator_ids].nil?

    approved = Hash.new
    @indicators = Indicator.find(params[:indicator_ids])
    @indicators.each do |indicator|
      approved[!indicator.approved]=approved[!indicator.approved].to_i+1 || 1
      indicator.update_attributes approved:!indicator.approved
      indicator.update_index
    end
    sleep 1
    respond_to do |format|
      format.html { redirect_to indicators_url(approved: approved[true].to_i<approved[false].to_i) }
      format.json { head :no_content }
    end
  end

  def permitted_params
    params[:indicator][:country_ids] ||= [] if params[:indicator].present?
    params.permit(indicator: [
      :id, :site_id, :title, :english_title, :author, :url, :source_url, :content,
      :biographical_region, :published_on, :published, :approved, :approved_at,
      tag_list: [], target_list: [], action_list: [],
      country_ids: [], language_ids: []
    ])
  end

  def notify_created_content
    ContentMailer.content_created_email(current_user, @indicator).deliver
  end

  def notify_updated_content
    ContentMailer.content_updated_email(current_user, @indicator).deliver
  end

  protected

  def collection
    @indicators ||= end_of_association_chain.search(params)
  end

end
