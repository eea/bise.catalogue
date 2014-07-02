class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role_admin, :boolean, default: false
    add_column :users, :role_validator, :boolean, default: false
    add_column :users, :role_author, :boolean, default: false
  end
end
