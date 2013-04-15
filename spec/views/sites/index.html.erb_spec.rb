require 'spec_helper'

describe "sites/index" do
  before(:each) do
    assign(:sites, [
      stub_model(Site,
        :name => "Name",
        :origin_url => "Origin Url",
        :description => "Description"
      ),
      stub_model(Site,
        :name => "Name",
        :origin_url => "Origin Url",
        :description => "Description"
      )
    ])
  end

  it "renders a list of sites" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Origin Url".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
