class EcosystemAssessment < ActiveRecord::Base

    attr_accessible :document_type

    attr_accessible :title
    attr_accessible :language
    attr_accessible :english_title

    attr_accessible :published_year
    attr_accessible :origin

    attr_accessible :is_final

    attr_accessible :license

    attr_accessible :url

end
