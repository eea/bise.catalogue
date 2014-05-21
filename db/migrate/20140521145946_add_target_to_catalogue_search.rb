class AddTargetToCatalogueSearch < ActiveRecord::Migration
  def change
    add_column :catalogue_searches, :target, :string
  end
end
