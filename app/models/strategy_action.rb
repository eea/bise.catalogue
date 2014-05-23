# Keyword Categories controller
class StrategyAction < ActiveRecord::Base
  attr_accessible :title
  attr_accessible :short_desc
  attr_accessible :target_id

  belongs_to :target

  def to_s
    title
  end
end
