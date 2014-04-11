class CreateKeywordContainers < ActiveRecord::Migration
  def change
    create_table :keyword_containers do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
