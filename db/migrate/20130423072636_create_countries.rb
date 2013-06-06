class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.boolean :eu15
      t.boolean :eu25
      t.boolean :eu27
      t.boolean :eu28
      t.boolean :eea

      t.timestamps
    end
  end
end
