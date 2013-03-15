class Concept < ActiveRecord::Base

    attr_accessible :definition
    attr_accessible :parent
    attr_accessible :title

    belongs_to :theme
    has_and_belongs_to_many :articles, :association_foreign_key => "article_id", :join_table => "articles_concepts", :class_name => "Article"

end
