class CreateLinksLanguagesJoinTable < ActiveRecord::Migration

    def up
        create_table :links_languages, :id => false do |t|
            t.integer :link_id
            t.integer :language_id
        end
    end

    def down
        drop_table :links_languages
    end

end
