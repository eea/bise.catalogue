require 'spec_helper'

describe SpeciesTranslation do

  before do
    @species_translation = FactoryGirl.create :species_translation
  end

  it { @species_translation.should be_valid }

end
