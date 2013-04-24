class Country < ActiveRecord::Base

    attr_accessible :code
    attr_accessible :name
    attr_accessible :eea
    attr_accessible :eu15
    attr_accessible :eu25
    attr_accessible :eu27
    attr_accessible :eu28

    has_and_belongs_to_many :articles, :association_foreign_key => "article_id", :join_table => "articles_countries", :class_name => "Article"

end
