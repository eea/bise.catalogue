class Link < ActiveRecord::Base

    belongs_to :countries

    attr_accessible :approved
    attr_accessible :approved_at
    attr_accessible :author
    attr_accessible :english_title
    attr_accessible :language
    attr_accessible :published_on
    attr_accessible :source
    attr_accessible :title
    attr_accessible :url

end
