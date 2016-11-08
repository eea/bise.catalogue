class AddVariousToGraphs < ActiveRecord::Migration
  def change
    add_column :graphs, :has_part, :text
    add_column :graphs, :is_part_of, :string
    add_column :graphs, :is_replaced_by, :string
    add_column :graphs, :thumbnail_link, :string
  end
end
