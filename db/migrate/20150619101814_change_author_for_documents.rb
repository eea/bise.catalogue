class ChangeAuthorForDocuments < ActiveRecord::Migration
  def change
    change_table :documents do |t|
      t.change :author, :text
    end
  end
end
