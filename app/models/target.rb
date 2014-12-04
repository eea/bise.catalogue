# Keyword Categories controller
class Target < ActiveRecord::Base
  attr_accessible :title
  attr_accessible :short_desc
  attr_accessible :actions_attributes

  has_many :strategy_actions
  accepts_nested_attributes_for :strategy_actions

  before_destroy :check_strategy_actions

  def to_s
    title
  end

  def full_name
    "#{title}: #{short_desc}"
  end

  def ordered_actions
    strategy_actions.order(:id)
  end

  private

  def check_strategy_actions
    if strategy_actions.size > 0
      errors[:base] << "Cannot delete a Target having associated strategy actions."
      return false
    end
  end
end
