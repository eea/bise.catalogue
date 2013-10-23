require 'spec_helper'

describe "protected_areas/show" do

  before(:each) do
    @protected_area = assign(:protected_area, FactoryGirl.create(:protected_area))
  end

  it "renders attributes in <p>" do
    render
  end

end
