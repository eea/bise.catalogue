class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login
  attr_accessible :password
  attr_accessible :password_confirmation
  attr_accessible :remember_me
  # attr_accessible :title, :body

  validates :login, presence: true
  validates :password, presence: true

  # Returns complete name
  def get_ldap_displayname
    Rails::logger.info("### Getting the users display name")
    tempname = Devise::LDAP::Adapter.get_ldap_param(self.login,"cn")
    tempname[0]
  end

  def get_ldap_email
    Rails::logger.info("### Getting the users email address")
    tempmail = Devise::LDAP::Adapter.get_ldap_param(self.login,"mail")
    tempmail[0]
  end

  # TODO : Pending
  def admin?
    Rails::logger.info("### Getting the users email address")
    groups = Devise::LDAP::Adapter.get_groups(self.login)
    # group = Devise::LDAP::Adapter.in_ldap_group?(self.login, "EIONET", group_attribute = nil)
    # tempmail = Devise::LdapAdapter.get_ldap_param(self.username,"mail")
    # group
    # "hola"
  end

end
