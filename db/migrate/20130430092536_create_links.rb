class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :english_title
      t.string :author
      t.datetime :published_on
      t.string :language
      t.string :source
      t.boolean :approved
      t.references :countries
      t.string :url
      t.datetime :approved_at

      t.timestamps
    end
    add_index :links, :countries_id
  end
end
