class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :origin_url
      t.string :description

      t.references :articles

      t.timestamps
    end
  end
end
