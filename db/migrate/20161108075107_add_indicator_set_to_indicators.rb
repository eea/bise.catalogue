class AddIndicatorSetToIndicators < ActiveRecord::Migration
  def change
    add_column :indicators, :indicator_set, :string
  end
end
