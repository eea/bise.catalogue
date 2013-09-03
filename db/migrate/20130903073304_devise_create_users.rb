class DeviseCreateUsers < ActiveRecord::Migration

  def change
    create_table(:users) do |t|
      ## LDAP authenticatable
      t.string :login, :null => false, :default => "", :unique => true

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Token authenticatable
      # t.string :authentication_token

      t.timestamps
    end

    add_index :users, :login, :unique => true
  end

end
