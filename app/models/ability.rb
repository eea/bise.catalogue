# Class that checks the roles based on user model
class Ability
  include CanCan::Ability

  def initialize(user)
    return false if user.nil?
    can :read, :all
    can [:new, :create], [Article, Document, Link] if user.role_author?

    # Only editable if created by user, user is an approver or admin
    [Article, Document, Link].each do |klazz|
      can [:edit, :update, :delete], klazz do |obj|
        obj.try(:creator) == user || user.role_validator? || user.role_admin?
      end
    end

    can :approve_multiple, [Article, Document, Link] if user.role_validator?
    can :manage, :all if user.role_admin?
  end
end
