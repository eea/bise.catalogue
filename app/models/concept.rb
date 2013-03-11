class Concept < ActiveRecord::Base

    attr_accessible :definition
    attr_accessible :parent
    attr_accessible :title

    belongs_to :theme

end
