class CreateCountriesBiogeoregionsJoinTable < ActiveRecord::Migration

    def up
        create_table :countries_biogeoregions, :id => false do |t|
            t.integer :country_id
            t.integer :biogeo_region_id
        end
    end

    def down
        drop_table :countries_biogeoregions
    end

end
