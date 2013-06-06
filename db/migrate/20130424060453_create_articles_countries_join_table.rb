class CreateArticlesCountriesJoinTable < ActiveRecord::Migration

    def up
        create_table :articles_countries, :id => false do |t|
            t.integer :article_id
            t.integer :country_id
        end
    end

    def down
        drop_table :articles_countries
    end

end
