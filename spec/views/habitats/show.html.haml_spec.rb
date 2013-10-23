require 'spec_helper'

describe "habitats/show" do

  before(:each) do
    @habitat = assign(:habitat, FactoryGirl.create(:habitat))
  end

  it "renders attributes in <p>" do
    render
  end

end
