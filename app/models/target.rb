# Keyword Categories controller
class Target < ActiveRecord::Base
  attr_accessible :title
  attr_accessible :short_desc
  attr_accessible :actions_attributes

  has_many :actions, dependent: :destroy
  accepts_nested_attributes_for :actions

  def to_s
    title
  end

  def full_name
    "#{title}: #{short_desc}"
  end
end
