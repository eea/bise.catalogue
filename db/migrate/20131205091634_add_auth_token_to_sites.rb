class AddAuthTokenToSites < ActiveRecord::Migration
  def change
    add_column :sites, :auth_token, :string
  end
end
