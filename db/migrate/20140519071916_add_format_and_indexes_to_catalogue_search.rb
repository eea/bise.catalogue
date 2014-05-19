class AddFormatAndIndexesToCatalogueSearch < ActiveRecord::Migration
  def change
    add_column :catalogue_searches, :format, :string
    add_column :catalogue_searches, :indexes, :string
  end
end
