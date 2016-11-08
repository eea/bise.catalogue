class AddVariousToIndicators < ActiveRecord::Migration
  def change
    add_column :indicators, :has_part, :text
    add_column :indicators, :is_part_of, :string
    add_column :indicators, :is_replaced_by, :string
    add_column :indicators, :thumbnail_link, :string
  end
end
