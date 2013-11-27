class ProtectedAreasController < InheritedResources::Base

  before_filter :authenticate_user!
  respond_to :html, only: [:index, :show]

protected
  def collection
    @protected_areas ||= end_of_association_chain.search(params)
  end

end
