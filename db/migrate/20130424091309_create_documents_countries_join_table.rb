class CreateDocumentsCountriesJoinTable < ActiveRecord::Migration

    def up
        create_table :documents_countries, :id => false do |t|
            t.integer :document_id
            t.integer :country_id
        end
    end

    def down
        drop_table :documents_countries
    end

end
