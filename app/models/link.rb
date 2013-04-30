class Link < ActiveRecord::Base
  belongs_to :countries
  attr_accessible :approved, :approved_at, :author, :english_title, :language, :published_on, :source, :title, :url
end
