class AddApprovedToArticle < ActiveRecord::Migration

  def change
    add_column :articles, :approved, :boolean, default: false
    add_column :articles, :approved_at, :datetime
  end

end
