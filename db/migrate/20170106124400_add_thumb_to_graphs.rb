class AddThumbToGraphs < ActiveRecord::Migration
  def change
    add_column :graphs, :thumb, :string
  end
end
