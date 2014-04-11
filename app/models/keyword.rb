# Keyword model for tag management
class Keyword < ActiveRecord::Base
  belongs_to :keyword_container
  attr_accessible :name
  attr_accessible :keyword_container_id

  accepts_nested_attributes_for :keyword_container
  validates_presence_of :keyword_container_id
end
