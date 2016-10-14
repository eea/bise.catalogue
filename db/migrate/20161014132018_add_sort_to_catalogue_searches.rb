class AddSortToCatalogueSearches < ActiveRecord::Migration
  def change
    add_column :catalogue_searches, :sort_on, :string
  end
end
