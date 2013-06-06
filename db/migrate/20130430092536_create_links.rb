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
      t.text    :biographical_region
      t.string :url
      t.string :comment
      t.string :description
      t.datetime :approved_at
      t.references :site
      t.timestamps
    end
  end
end
