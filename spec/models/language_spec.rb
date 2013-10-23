require 'spec_helper'

describe Language do

  before do
    @language = FactoryGirl.create :language
  end

  it "should be valid" do
    should be_valid
  end

end
