class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.string :title
      t.integer :parent
      t.text :definition
      t.references :themes
      t.references :articles

      t.timestamps
    end
  end
end
