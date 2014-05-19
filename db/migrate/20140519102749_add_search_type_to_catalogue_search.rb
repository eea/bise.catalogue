class AddSearchTypeToCatalogueSearch < ActiveRecord::Migration
  def change
    add_column :catalogue_searches, :search_type, :string
  end
end
