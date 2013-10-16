module Classifiable
  extend ActiveSupport::Concern

  included do

    belongs_to              :site
    attr_accessible         :site_id
    attr_accessible         :title
    attr_accessible         :english_title
    attr_accessible         :author
    attr_accessible         :source_url

    attr_accessible         :language_ids
    has_and_belongs_to_many :languages, class_name: 'Language', join_table: "#{name.pluralize.downcase}_languages", foreign_key: "#{name.downcase}_id"

    attr_accessible         :biographical_region

    attr_accessible         :published_on
    attr_accessible         :published

    attr_accessible         :approved
    attr_accessible         :approved_at

    attr_accessible         :country_ids
    has_and_belongs_to_many :countries, class_name: "Country", join_table: "#{name.pluralize.downcase}_countries", foreign_key: "#{name.downcase}_id"

    validates :site          , presence: true
    validates :title         , presence: true , length: { maximum: 255 }
    validates :english_title , presence: true , length: { maximum: 255 }

    validates :author        , presence: true , length: { maximum: 255}
    validates :language_ids  , presence: true
    validate :published_on_is_valid_date

    def published_on_is_valid_date
      errors.add(:published_on, :not_valid) unless published_on.class == Date
    end

  end

end