class CreateLibraryRoles < ActiveRecord::Migration
  def change
    create_table :library_roles do |t|
      t.integer :user_id
      t.integer :site_id
      t.boolean :allowed, default: false
    end
  end
end
