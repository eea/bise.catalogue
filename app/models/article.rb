class Article < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :title, :content, :published_on
end
