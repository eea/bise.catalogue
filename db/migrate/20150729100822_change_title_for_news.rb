class ChangeTitleForNews < ActiveRecord::Migration
  def change
    change_table :news do |t|
      t.change :title, :text
      t.change :english_title, :text
    end
  end
end
