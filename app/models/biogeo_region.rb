class BiogeoRegion < ActiveRecord::Base

    attr_accessible :code
    attr_accessible :area_name

    has_many :countries
    has_and_belongs_to_many :protected_areas, association_foreign_key: "protected_area_id", join_table: "biogeo_regions_protected_areas", class_name: "ProtectedArea"

end
