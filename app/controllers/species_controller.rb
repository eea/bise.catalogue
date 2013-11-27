class SpeciesController < InheritedResources::Base

  before_filter :authenticate_user!
  respond_to :html, only: [:index, :show]

protected
  def collection
    @species ||= end_of_association_chain.search(params)
  end

end
