class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email
  attr_accessible :password
  attr_accessible :password_confirmation
  attr_accessible :remember_me

  def login=(login)
    @login = login
  end

  def login
    @login || self.email
  end

  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   login = conditions.delete(:login)
  #   where(conditions).where(["lower(email) = :value", { value: login.strip.downcase }]).first
  # end
end

