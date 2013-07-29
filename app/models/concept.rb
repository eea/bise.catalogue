class Concept < ActiveRecord::Base

  attr_accessible :title
  attr_accessible :definition
  attr_accessible :parent

  has_and_belongs_to_many :themes, :association_foreign_key => "theme_id", :join_table => "themes_concepts", :class_name => "Theme"

  has_and_belongs_to_many :articles, :association_foreign_key => "article_id", :join_table => "articles_concepts", :class_name => "Article"
  has_and_belongs_to_many :documents, :association_foreign_key => "document_id", :join_table => "documents_concepts", :class_name => "Document"

end
