class CreateLinksCountriesJoinTable < ActiveRecord::Migration

    def up
        create_table :links_countries, :id => false do |t|
            t.integer :link_id
            t.integer :country_id
        end
    end

    def down
        drop_table :links_countries
    end

end
