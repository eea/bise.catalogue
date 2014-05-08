# Keyword Categories controller
class Action < ActiveRecord::Base
  attr_accessible :title
  attr_accessible :short_desc

  belongs_to :keyword_container

  def to_s
    title
  end
end
