class Theme < ActiveRecord::Base
    attr_accessible :title

    has_many :concepts

    has_many :articles
end
