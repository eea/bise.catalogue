class Site < ActiveRecord::Base

  attr_accessible :description
  attr_accessible :name
  attr_accessible :origin_url
  attr_accessible :auth_token

  has_many :articles
  has_many :documents
	has_many :links
	has_many :news

  validates :name, uniqueness: true

  before_save :generate_auth_token

  private

  def generate_auth_token
    self.auth_token =  Digest::MD5.hexdigest(name) unless auth_token.present?
  end

end
