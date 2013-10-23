require 'spec_helper'

describe Species do

  before do
    @species = FactoryGirl.create :species
  end

  it "should be valid" do
    @species.should be_valid
  end

end
