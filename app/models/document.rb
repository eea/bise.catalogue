class Document < ActiveRecord::Base
  attr_accessible :author, :description, :downloads, :filename, :name

  validates_presence_of :name, :on => :create, :message => "can't be blank"
end
