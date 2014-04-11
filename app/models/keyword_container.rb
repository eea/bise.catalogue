# Keyword Categories controller
class KeywordContainer < ActiveRecord::Base
  attr_accessible :description
  attr_accessible :title
  attr_accessible :keywords

  has_many :keywords

  def to_s
    title
  end
end
