class Theme < ActiveRecord::Base
    attr_accessible :title

    has_many :concepts
end
