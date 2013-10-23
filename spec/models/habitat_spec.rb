require 'spec_helper'

describe Habitat do

  before do
    @habitat = FactoryGirl.create :habitat
  end

  it "should be valid" do
    @habitat.should be_valid
  end

end
