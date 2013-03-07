class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :title

      t.timestamps
    end
  end
end
