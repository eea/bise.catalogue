class CreateArticlesLanguagesJoinTable < ActiveRecord::Migration

    def up
        create_table :articles_languages, :id => false do |t|
            t.integer :article_id
            t.integer :language_id
        end
    end

    def down
        drop_table :articles_languages
    end

end
