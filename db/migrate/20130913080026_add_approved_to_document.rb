class AddApprovedToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :approved_at, :datetime
  end
end
