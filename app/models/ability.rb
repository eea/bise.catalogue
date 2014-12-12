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

    can [:update, :destroy], [Article, Document, Link] do |obj|
      creator_has_access?(user, obj) || editable_by_user?(user, obj)
    end

    can :approve_multiple, [Article, Document, Link] if user.role_validator?
    can :manage, :all if user.role_admin?

    if user.role_admin?
      admin_objs = [KeywordContainer, Keyword, Target, StrategyAction, Site, User]
      can [:index, :create, :edit, :update, :destroy, :admin], admin_objs
    end

    # can :index, Target do |t|
    #   # user.role_admin?
    #   false
    # end

    # can :index, Target if user.role_admin?
    # can :read, Keyword if user.role_admin?
  end

  def creator_has_access?(user, obj)
    obj.try(:creator) == user &&
    obj.try(:creator).library_roles.where(site_id: obj.site_id)
  end

  # If not from the same author, needs to check object's library permissions
  def editable_by_user?(user, obj)
    if user.role_validator?
      user.library_roles.where(site_id: obj.site_id).try(:first).try(:allowed)
    elsif user.role_admin?
      true
    else
      false
    end
  end
end
