class Site < ActiveRecord::Base

  attr_accessible :description
  attr_accessible :name
  attr_accessible :origin_url
  attr_accessible :auth_token

  has_many :library_roles

  has_many :articles
  has_many :documents
  has_many :links
  has_many :news

  acts_as_taggable_on :targets, :actions
  attr_accessible :target_list, :action_list

  validates :name, uniqueness: true, presence: true

  before_save :generate_auth_token
  before_destroy :check_associates

  def content_count
    articles.size + documents.size + links.size
  end

  private

  def generate_auth_token
    self.auth_token =  Digest::MD5.hexdigest(name) unless auth_token.present?
  end

  def check_associates
    if content_count > 0
      errors[:base] << "Cannot delete library having associated content."
      return false
    end
  end

end
