# Class that checks the roles based on user model
class Ability
  include CanCan::Ability

  def initialize(user)
    return false if user.nil?
    can :read, :all
    # can [:new, :create], [Article, Document, Link] if user.role_author?

    can :new, [Article, Document, Link] if user.role_author?
    can :create, [Article, Document, Link] do |obj|
      unless obj.try(:site_id).nil?
        user.library_roles.where(site_id: obj.site_id).try(:first).try(:allowed) || false
      else
        false
      end
    end

    # Only editable if created by user, user is an approver or admin
    can [:edit, :update, :delete], [Article, Document, Link] do |obj|
      obj.try(:creator) == user || user.role_validator? || user.role_admin?
    end

    can :approve_multiple, [Article, Document, Link] if user.role_validator?
    can :manage, :all if user.role_admin?
  end
end
