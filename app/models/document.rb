class Document < ActiveRecord::Base
  attr_accessible :author, :description, :downloads, :filename, :name
end
