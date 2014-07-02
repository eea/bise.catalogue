# Class that checks the roles based on user model
class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can [:create, :edit], [Article, Document, Link] if user.role_author?
    can :approve_multiple, [Article, Document, Link] if user.role_validator?
    can :manage, :all if user.role_admin?
  end
end
