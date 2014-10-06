class DocumentsController < ApplicationController
  inherit_resources

  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy]
  before_filter :authenticate_user!
  has_scope :approved, type: :boolean

  after_filter :notify_created_content, only: :create
  after_filter :notify_updated_content, only: :update

  def index
    if params[:format] == 'xls'
      params[:per_page] = 1000
      response.headers["ContentType"] = "text/xml"
      response.headers["Content-Disposition"] = "attachment"
    end
    @documents = Document.search(params)

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def create
    @document = Document.new(permitted_params[:document])
    @document.creator = current_user
    create!
  end

  def update
    @document = Document.find(params[:id])
    @document.modifier = current_user
    @document.save!
    update!
  end

  def approve_multiple
    if (params[:document_ids].nil?)
      respond_to do |format|
        format.html { redirect_to documents_path, alert: "Please, select at least one document!" }
      end
      return
    end

    @documents = Document.find(params[:document_ids])
    @documents.each do |document|
      document.approved = !document.approved
      document.save!
    end
    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  def permitted_params
    params[:document][:country_ids] ||= [] if params[:document].present?
    params.permit(document:[
      :id, :site_id, :title, :english_title, :author, :source_url, :file,
      :biographical_region, :published_on, :published, :approved, :approved_at,
      :description, tag_list: [], target_list: [], action_list: [],
      country_ids: [], language_ids: []
    ])
  end

  def notify_created_content
    ContentMailer.content_created_email(current_user, @document).deliver
  end

  def notify_updated_content
    ContentMailer.content_updated_email(current_user, @document).deliver
  end

  protected

  def collection
    @documents ||= end_of_association_chain.search(params)
  end

end
