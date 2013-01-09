class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :description
      t.string :filename
      t.string :author
      t.integer :downloads

      t.timestamps
    end
  end
end
