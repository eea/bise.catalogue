class Theme < ActiveRecord::Base
    attr_accessible :title

    has_and_belongs_to_many :concepts, :class_name => "Concept", :join_table => "themes_concepts", :foreign_key => "theme_id"
end
