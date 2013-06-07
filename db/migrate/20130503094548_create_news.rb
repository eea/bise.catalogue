class CreateNews < ActiveRecord::Migration

    def change
        create_table :news do |t|
            t.boolean :approved
            t.datetime :approved_at
            t.string :author
            t.string :english_title
            t.string :language
            t.datetime :published_on
            t.string :source
            t.string :title
            t.string :url
            t.string :abstract
            t.string :comment
            t.string :published
            t.references :site
            t.text        :biographical_region
            t.timestamps
        end
    end

end
