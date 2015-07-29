class ChangeTitleForLinks < ActiveRecord::Migration
  def change
    change_table :links do |t|
      t.change :title, :text
      t.change :english_title, :text
    end
  end
end
