class CreateThemes < ActiveRecord::Migration

    def change
        create_table :themes do |t|
            t.string :title
            t.references :concepts

            t.timestamps
        end
    end

end

