class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :title
      t.string :short_desc
      t.references :target

      t.timestamps
    end
    add_index :actions, :target_id
  end
end
