class CreateSpeciesProtectedAreasJoinTable < ActiveRecord::Migration

    def up
        create_table :species_protected_areas, :id => false do |t|
            t.integer :species_id
            t.integer :protected_area_id
        end
    end

    def down
        drop_table :species_protected_areas
    end

end
