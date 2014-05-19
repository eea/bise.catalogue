class AddLocationToCatalogueSearch < ActiveRecord::Migration
  def change
    add_column :catalogue_searches, :location, :string
  end
end
