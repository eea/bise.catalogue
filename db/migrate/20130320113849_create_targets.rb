class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :title
      t.string :short_desc

      t.timestamps
    end
  end
end
