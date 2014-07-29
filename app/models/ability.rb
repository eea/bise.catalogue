# Class that checks the roles based on user model
class Ability
  include CanCan::Ability

  def initialize(user)
    return false if user.nil?
    can :read, :all
    if user.role_author?
      can [:new, :create, :edit, :update], [Article, Document, Link]
    end
    can :approve_multiple, [Article, Document, Link] if user.role_validator?
    can :manage, :all if user.role_admin?
  end
end
