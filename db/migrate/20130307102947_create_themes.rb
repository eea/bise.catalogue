class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :title
      t.references :concepts

      t.references :articles

      t.timestamps
    end
  end
end
