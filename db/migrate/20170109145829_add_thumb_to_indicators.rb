class AddThumbToIndicators < ActiveRecord::Migration
  def change
    add_column :indicators, :thumb, :string
  end
end
