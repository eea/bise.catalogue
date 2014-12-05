# Class that checks the roles based on user model
class Ability
  include CanCan::Ability

  def initialize(user)
    return false if user.nil?
    can :read, :all
    can :new, [Article, Document, Link] if user.role_author?
    can :create, [Article, Document, Link] do |obj|
      user.library_roles.where(site_id: obj.site_id).try(:first).try(:allowed) || false
    end

    can [:update, :delete], [Article, Document, Link] do |obj|
      obj.try(:creator) == user || editable_by_user?(user, obj)
    end

    can :approve_multiple, [Article, Document, Link] if user.role_validator?
    can :manage, :all if user.role_admin?
  end

  # If not from the same author, needs to check object's library permissions
  def editable_by_user?(user, obj)
    if user.role_validator? || user.role_admin?
      user.library_roles.where(site_id: obj.site_id).try(:first).try(:allowed)
    else
      false
    end
  end
end
