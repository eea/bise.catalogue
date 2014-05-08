# Keyword Categories controller
class KeywordContainer < ActiveRecord::Base
  attr_accessible :description
  attr_accessible :title
  # attr_accessible :keywords
  attr_accessible :keywords_attributes

  has_many :keywords, dependent: :destroy
  accepts_nested_attributes_for :keywords


  def to_s
    title
  end
end
