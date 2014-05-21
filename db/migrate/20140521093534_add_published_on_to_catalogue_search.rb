class AddPublishedOnToCatalogueSearch < ActiveRecord::Migration
  def change
    add_column :catalogue_searches, :published_on, :string
  end
end
