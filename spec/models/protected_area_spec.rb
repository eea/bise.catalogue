require 'spec_helper'

describe ProtectedArea do

  before do
    @site = FactoryGirl.create :protected_area
  end

  it "should be valid" do
    @site.should be_valid
  end

end
