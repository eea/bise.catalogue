class HabitatsController < InheritedResources::Base

  before_filter :authenticate_user!
  respond_to :html, only: [:index, :show]

protected
  def collection
    @habitats ||= end_of_association_chain.search(params)
  end

end
