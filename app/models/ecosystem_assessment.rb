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


    # ---- VALIDATIONS
    validates_presence_of :title, :message => "can't be blank"
    validates_length_of :title, :within => 3..255, :message => "must be present"

    validates_presence_of :language, :message => "can't be blank"
    validates_presence_of :english_title, :message => "can't be blank"

    validates_presence_of :published_year, :message => "can't be blank"

    validates_presence_of :origin, :message => "can't be blank"

    validates_presence_of :is_final, :message => "can't be blank"

end
