class LinksController < InheritedResources::Base

  before_filter :authenticate_user!

  def approve_multiple
    if (params[:link_ids].nil?)
      respond_to do |format|
        format.html { redirect_to links_path, alert: "Please, select at least one link!" }
      end
      return
    end

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

protected
  def collection
    @links ||= end_of_association_chain.search(params)
  end

end
