class Language < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :name

    has_and_belongs_to_many :documents, :association_foreign_key => "document_id", :join_table => "documents_languages", :class_name => "Document"

    index_name "#{Tire::Model::Search.index_prefix}languages"

    refresh = lambda { Tire::Index.new(index_name).refresh }
    after_save(&refresh)
    after_destroy(&refresh)

    mapping do
        indexes :id,    :index    => :not_analyzed
        indexes :name,  :analyzer => 'snowball'
    end

end
