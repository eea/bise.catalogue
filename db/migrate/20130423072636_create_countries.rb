class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :uri
      t.string :name
      t.string :code
      t.boolean :eu15
      t.boolean :eu25
      t.boolean :eu27
      t.boolean :eu28
      t.boolean :eea

      t.string :iso_code2
      t.string :iso_code3
      t.integer :iso_n
      t.string :iso_2_wcmc
      t.string :iso_3_wcmc
      t.string :iso_3_wcmc_parent
      t.string :areucd
      t.integer :surface
      t.integer :population
      t.string :capital

      t.boolean :selection

      t.timestamps
    end
  end
end
