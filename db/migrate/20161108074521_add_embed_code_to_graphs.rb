class AddEmbedCodeToGraphs < ActiveRecord::Migration
  def change
    add_column :graphs, :embed_code, :text
  end
end
