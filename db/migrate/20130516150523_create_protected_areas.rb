class CreateProtectedAreas < ActiveRecord::Migration

    def change
        create_table :protected_areas do |t|
            t.integer :code
            t.string :iucnat
            t.string :uri
            t.string :name
            t.integer :designation_year
            t.string :nuts_code
            t.float :area
            t.float :length
            t.float :long
            t.float :lat
            t.string :source_db

            t.timestamps
        end
    end

end
