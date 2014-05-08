# Keyword model for tag management
class Keyword < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :keyword_container_id

  belongs_to :keyword_container
end
