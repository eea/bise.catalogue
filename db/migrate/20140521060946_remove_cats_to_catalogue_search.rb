class RemoveCatsToCatalogueSearch < ActiveRecord::Migration
  def change
    remove_column :catalogue_searches, :document
    remove_column :catalogue_searches, :webpage
    remove_column :catalogue_searches, :link
    remove_column :catalogue_searches, :protected_site
    remove_column :catalogue_searches, :habitat
    remove_column :catalogue_searches, :species
  end
end
