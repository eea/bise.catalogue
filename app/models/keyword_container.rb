# Keyword Categories controller
class KeywordContainer < ActiveRecord::Base
  attr_accessible :description
  attr_accessible :title
  # attr_accessible :keywords
  attr_accessible :keywords_attributes

  has_many :keywords
  accepts_nested_attributes_for :keywords

  before_destroy :check_children_keywords

  def to_s
    title
  end

  private

  def check_children_keywords
    if keywords.size > 0
      errors[:base] << "Cannot delete a container having associated keywords."
      return false
    end
  end
end
