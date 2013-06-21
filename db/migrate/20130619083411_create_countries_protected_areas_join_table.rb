class CreateCountriesProtectedAreasJoinTable < ActiveRecord::Migration

    def up
        create_table :countries_protected_areas, :id => false do |t|
            t.integer :country_id
            t.integer :protected_area_id
        end
    end

    def down
        drop_table :countries_protected_areas
    end

end
