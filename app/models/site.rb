class Site < ActiveRecord::Base

  attr_accessible :description
  attr_accessible :name
  attr_accessible :origin_url

  has_many :articles
  has_many :documents
	has_many :links
	has_many :news

end
