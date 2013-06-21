class CreateBiogeoRegionsProtectedAreasJoinTable < ActiveRecord::Migration

    def up
        create_table :biogeo_regions_protected_areas, :id => false do |t|
            t.integer :biogeo_region_id
            t.integer :protected_area_id
        end
    end

    def down
        drop_table :biogeo_regions_protected_areas
    end

end
