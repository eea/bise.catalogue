class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable, :trackable, authentication_keys: [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login
  attr_accessible :password
  attr_accessible :password_confirmation
  attr_accessible :remember_me

  validates :login, presence: true
  validates :password, presence: true

  # Returns complete name
  def get_ldap_displayname
    Devise::LDAP::Adapter.get_ldap_param(self.login,"cn").first
  end

  def get_ldap_email
    Devise::LDAP::Adapter.get_ldap_param(self.login,"mail").first
  end

  def approver?
    admin_role = "cn=extranet-bise-cat-approve,cn=extranet-bise-cat,cn=extranet-bise,cn=extranet,ou=Roles,o=EIONET,l=Europe"
    Devise::LDAP::Adapter.get_groups(self.login).include? admin_role
  end

end
