class ChangeAuthorForNews < ActiveRecord::Migration
  def change
    change_table :news do |t|
      t.change :author, :text
    end
  end
end
