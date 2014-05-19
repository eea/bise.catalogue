class AddIpToCatalogueSearch < ActiveRecord::Migration
  def change
    add_column :catalogue_searches, :queried_from_ip, :string
  end
end
