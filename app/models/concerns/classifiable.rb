# Basic logic for all catalogable content-types
module Classifiable
  extend ActiveSupport::Concern

  included do
    has_paper_trail

    scope :unapproved, where(approved: false)
    scope :approved, where(approved: true)

    belongs_to :site
    attr_accessible :site_id
    attr_accessible :title
    attr_accessible :english_title
    attr_accessible :author
    attr_accessible :source_url

    attr_accessible :language_ids
    has_and_belongs_to_many :languages, class_name: 'Language', join_table: "#{name.pluralize.downcase}_languages", foreign_key: "#{name.downcase}_id"

    attr_accessible :biographical_region
    validates_presence_of :biographical_region, unless: lambda { self.biographical_region.blank? }

    attr_accessible :published_on
    attr_accessible :published

    belongs_to :creator, class_name: 'User'
    belongs_to :modifier, class_name: 'User'

    attr_accessible :approved
    attr_accessible :approved_at

    attr_accessible :country_ids
    has_and_belongs_to_many :countries, class_name: "Country", join_table: "#{name.pluralize.downcase}_countries", foreign_key: "#{name.downcase}_id"

    validates :site          , presence: true
    validates :title         , presence: true , length: { maximum: 512 }
    validates :english_title , presence: true , length: { maximum: 512 }

    validates :author        , presence: true , length: { maximum: 2048 }
    validates :language_ids  , presence: true
    validate :published_on_is_valid_date

    validates :source_url    , uniqueness: true, if: lambda{ |object| object.source_url.present? }


    scope :approved, -> { where(approved: true) }
    scope :unapproved, -> { where(approved: false) }


    def published_on_is_valid_date
      errors.add(:published_on, :not_valid) unless published_on.class == Date
    end

    def editable_by?(user)
      if source_url.blank?
        (creator.eql?(user) && user.library_roles.where(site_id: site.id).try(:first).try(:allowed)) ||
        user.approver? && user.library_roles.where(site_id: site.id).try(:first).try(:allowed) ||
        user.role_admin?
      else
        false
      end
    end

    def disabled?(user)
      (editable_by?(user)) ? '' : 'disabled'
    end

    def splitted_authors
      return [] if author.nil?
      author.gsub(/\sand/, ';').split(/\;/).map { |a| a.strip }
    end
  end
end
