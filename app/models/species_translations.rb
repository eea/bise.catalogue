class SpeciesTranslations < ActiveRecord::Base

  belongs_to :species

  attr_accessible :locale
  attr_accessible :name

end
