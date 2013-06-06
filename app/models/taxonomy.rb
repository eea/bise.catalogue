class Taxonomy < ActiveRecord::Base

    has_many :species
    belongs_to :parent, :class_name => 'Taxonomy'

    attr_accessible :code
    attr_accessible :level
    attr_accessible :name

end
