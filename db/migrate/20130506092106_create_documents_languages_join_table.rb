class CreateDocumentsLanguagesJoinTable < ActiveRecord::Migration

    def up
        create_table :documents_languages, :id => false do |t|
            t.integer :document_id
            t.integer :language_id
        end
    end

    def down
        drop_table :documents_languages
    end

end
