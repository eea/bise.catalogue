class EcosystemAssessment < ActiveRecord::Base

    attr_accessible :resource_type

    attr_accessible :title
    attr_accessible :language
    attr_accessible :english_title

    attr_accessible :published_year
    attr_accessible :origin

    attr_accessible :is_final

    # license
    attr_accessible :availability

    attr_accessible :url

    # ---- VALIDATIONS
    validates_inclusion_of :resource_type, :in => %w( Literature Tool Event Website Maps ), :message => "Resource type is not included in the list"

    validates_presence_of :title, :message => "can't be blank"
    validates_length_of :title, :within => 3..255, :message => "must be present"

    validates_presence_of :language, :message => "can't be blank"
    validates_format_of :language, :with => /\A[a-zA-Z]+\z/, :message => "is invalid"

    validates_presence_of :english_title, :message => "can't be blank"

    validates_presence_of :published_year, :message => "can't be blank"
    validates_format_of :published_year, :with => /\d\d\d\d/, :message => "is invalid"

    validates_presence_of :origin, :message => "can't be blank"

    validates_inclusion_of :is_final, :in => [true, false], :message => "can't be blank"

end
