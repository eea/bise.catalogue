require 'spec_helper'

describe "sites/show" do

  before(:each) do
    @site = assign(:site, FactoryGirl.create(:site))
  end

  it "renders attributes in <p>" do
    render
  end

end
