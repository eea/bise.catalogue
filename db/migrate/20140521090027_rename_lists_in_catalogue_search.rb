class RenameColsInCatalogueSearch < ActiveRecord::Migration
  def change
    rename_column :catalogue_searches, :countries_list, :countries
    rename_column :catalogue_searches, :languages_list, :languages
  end
end
