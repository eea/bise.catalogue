class ThemesConceptsJoinTable < ActiveRecord::Migration

    def up
        create_table :themes_concepts, :id => false do |t|
          t.integer :theme_id
          t.integer :concept_id
        end

        # add_index :themes_concepts, [ :theme_id, :concept_id ]
    end

    def down
        drop_table :themes_concepts
        # remove_index :themes_concepts, [ :theme_id, :concept_id ]
    end

end
