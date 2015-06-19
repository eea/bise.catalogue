class ChangeAuthorForLinks < ActiveRecord::Migration
  def change
    change_table :links do |t|
      t.change :author, :text
    end
  end
end
