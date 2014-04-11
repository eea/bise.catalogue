class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :name
      t.references :keyword_container

      t.timestamps
    end
    add_index :keywords, :keyword_container_id
  end
end
