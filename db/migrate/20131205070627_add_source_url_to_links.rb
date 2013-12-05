class AddSourceUrlToLinks < ActiveRecord::Migration
  def change
    add_column :links, :source_url, :string
  end
end
