class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role_admin, :boolean
    add_column :users, :role_validator, :boolean
    add_column :users, :role_author, :boolean
  end
end
