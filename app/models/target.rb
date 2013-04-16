class Target < ActiveRecord::Base

    attr_accessible :title
    attr_accessible :short_desc

    has_many :actions

end
