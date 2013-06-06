class CreateNewsCountriesJoinTable < ActiveRecord::Migration
  def up
        create_table :newss_countries, :id => false do |t|
            t.integer :news_id
            t.integer :country_id
        end
    end

    def down
        drop_table :news_countries
    end
end
