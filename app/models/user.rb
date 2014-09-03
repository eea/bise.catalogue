class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable, :trackable, authentication_keys: [:login]

  scope :admins, -> { where(role_admin: true) }
  scope :approvers, -> { where(role_validator: true) }
  scope :authors, -> { where(role_author: true) }

  has_many :library_roles
  accepts_nested_attributes_for :library_roles

  before_save :fetch_user_data

  attr_accessible :login
  attr_accessible :password
  attr_accessible :password_confirmation
  attr_accessible :remember_me
  attr_accessible :library_roles

  validates :login, presence: true

  def approver?
    admin_role = 'cn=extranet-bise-cat-approve,cn=extranet-bise-cat,cn=extranet-bise,cn=extranet,ou=Roles,o=EIONET,l=Europe'
    Devise::LDAP::Adapter.get_groups(self.login).include? admin_role
  end

  def role
    return 'Admin' if role_admin?
    return 'Approver' if role_validator?
    return 'Author' if role_author?
    'Guest'
  end

  def update_library_roles
    Site.find_each do |site|
      unless library_roles.where(site_id: site.id ).size > 0
        library_roles.push LibraryRole.new(user_id: id, site_id: site.id)
      end
      save!
    end
  end

  private

  def fetch_user_data
    # self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,'mail')
    self.name = Devise::LDAP::Adapter.get_ldap_param(login, 'cn').first
    self.email = Devise::LDAP::Adapter.get_ldap_param(login, 'mail').first
    if self.approver?
      self.role_author = true
      self.role_validator = true
    else
      self.role_author = true
    end
  end
end
