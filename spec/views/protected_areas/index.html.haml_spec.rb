require 'spec_helper'

describe "protected_areas/index" do
  before(:each) do
    assign(:protected_areas, [
      stub_model(ProtectedArea,
        :code => 1,
        :uri => "Uri",
        :name => "Name",
        :designation_year => 2,
        :nuts_code => "Nuts Code",
        :area => "",
        :length => "",
        :long => "",
        :lat => "",
        :source_db => "Source Db"
      ),
      stub_model(ProtectedArea,
        :code => 1,
        :uri => "Uri",
        :name => "Name",
        :designation_year => 2,
        :nuts_code => "Nuts Code",
        :area => "",
        :length => "",
        :long => "",
        :lat => "",
        :source_db => "Source Db"
      )
    ])
  end

  it "renders a list of protected_areas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Uri".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Nuts Code".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Source Db".to_s, :count => 2
  end
end
