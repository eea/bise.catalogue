class RenameColsInCatalogueSearch < ActiveRecord::Migration
  def change
    rename_column :catalogue_searches, :countries, :countries_list
    rename_column :catalogue_searches, :languages, :languages_list
  end
end
