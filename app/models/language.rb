class Language < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :name

    has_and_belongs_to_many :articles, :association_foreign_key => "article_id", :join_table => "articles_languages", :class_name => "Article"
    has_and_belongs_to_many :documents, :association_foreign_key => "document_id", :join_table => "documents_languages", :class_name => "Document"
    has_and_belongs_to_many :links, :association_foreign_key => "link_id", :join_table => "links_languages", :class_name => "Link"

    index_name "#{Tire::Model::Search.index_prefix}languages"

    refresh = lambda { Tire::Index.new(index_name).refresh }
    after_save(&refresh)
    after_destroy(&refresh)

    mapping do
        indexes :id,    :index    => :not_analyzed
        indexes :name,  :analyzer => 'snowball'
    end

end
