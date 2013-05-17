require 'spec_helper'

describe "habitats/index" do
  before(:each) do
    assign(:habitats, [
      stub_model(Habitat,
        :uri => "Uri",
        :code => 1,
        :name => "Name",
        :natura2000_code => 2,
        :habitat_code => "Habitat Code",
        :level => 3,
        :originally_published_code => 4,
        :description => "Description",
        :comment => "Comment",
        :national_name => "National Name"
      ),
      stub_model(Habitat,
        :uri => "Uri",
        :code => 1,
        :name => "Name",
        :natura2000_code => 2,
        :habitat_code => "Habitat Code",
        :level => 3,
        :originally_published_code => 4,
        :description => "Description",
        :comment => "Comment",
        :national_name => "National Name"
      )
    ])
  end

  it "renders a list of habitats" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Uri".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Habitat Code".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => "National Name".to_s, :count => 2
  end
end
