require 'spec_helper'

describe Country do

  before do
    @country = FactoryGirl.create(:country)
  end

  it "should be valid" do
    should be_valid
  end

end
