class CreateProtectedAreasHabitatsJoinTable < ActiveRecord::Migration

    def up
        create_table :protected_areas_habitats, :id => false do |t|
            t.integer :protected_area_id
            t.integer :habitat_id
        end
    end

    def down
        drop_table :protected_areas_habitats
    end

end
