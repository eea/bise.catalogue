class CreateUnprocessedObjects < ActiveRecord::Migration
  def change
    create_table :unprocessed_objects do |t|
      t.string :model
      t.string :http_method
      t.string :field
      t.string :message
      t.string :ip
      t.text :params

      t.timestamps
    end
  end
end
