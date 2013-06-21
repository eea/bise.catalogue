class CreateSpeciesHabitatsJoinTable < ActiveRecord::Migration

    def up
        create_table :species_habitats, :id => false do |t|
            t.integer :species_id
            t.integer :habitat_id
        end
    end

    def down
        drop_table :species_habitats
    end

end
