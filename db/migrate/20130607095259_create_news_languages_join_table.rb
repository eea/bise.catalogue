class CreateNewsLanguagesJoinTable < ActiveRecord::Migration

    def up
        create_table :news_languages, :id => false do |t|
            t.integer :news_id
            t.integer :language_id
        end
    end

    def down
        drop_table :news_languages
    end

end
