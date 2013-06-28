class CreateHabitats < ActiveRecord::Migration
  def change
    create_table :habitats do |t|
      t.string :uri
      t.integer :code
      t.string :name
      t.integer :natura2000_code
      t.string :habitat_code
      t.integer :level
      t.integer :originally_published_code
      t.text :description
      t.text :comment
      t.string :national_name

      t.timestamps
    end
  end
end
