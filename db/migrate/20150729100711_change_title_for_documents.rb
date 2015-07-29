class ChangeTitleForDocuments < ActiveRecord::Migration
  def change
    change_table :documents do |t|
      t.change :title, :text
      t.change :english_title, :text
    end
  end
end
