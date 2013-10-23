require 'spec_helper'

describe "sites/edit" do

  before(:each) do
    @site = assign(:site, FactoryGirl.create(:site))
  end

  it "renders the edit site form" do
    render
    assert_select "form", :action => sites_path(@site), :method => "post"
  end

end
