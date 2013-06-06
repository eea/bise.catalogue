class CreateTaxonomies < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
      t.integer :code
      t.string :name
      t.string :level

      t.references :parent

      t.timestamps
    end
    add_index :taxonomies, :parent_id
  end
end
