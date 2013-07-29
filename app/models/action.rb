class Action < ActiveRecord::Base

  attr_accessible :title
  attr_accessible :short_desc

  belongs_to :target

end
