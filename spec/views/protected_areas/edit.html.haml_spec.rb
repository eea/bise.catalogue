require 'spec_helper'

describe "protected_areas/edit" do
  before(:each) do
    @protected_area = assign(:protected_area, stub_model(ProtectedArea,
      :code => 1,
      :uri => "MyString",
      :name => "MyString",
      :designation_year => 1,
      :nuts_code => "MyString",
      :area => "",
      :length => "",
      :long => "",
      :lat => "",
      :source_db => "MyString"
    ))
  end

  it "renders the edit protected_area form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", protected_area_path(@protected_area), "post" do
      assert_select "input#protected_area_code[name=?]", "protected_area[code]"
      assert_select "input#protected_area_uri[name=?]", "protected_area[uri]"
      assert_select "input#protected_area_name[name=?]", "protected_area[name]"
      assert_select "input#protected_area_designation_year[name=?]", "protected_area[designation_year]"
      assert_select "input#protected_area_nuts_code[name=?]", "protected_area[nuts_code]"
      assert_select "input#protected_area_area[name=?]", "protected_area[area]"
      assert_select "input#protected_area_length[name=?]", "protected_area[length]"
      assert_select "input#protected_area_long[name=?]", "protected_area[long]"
      assert_select "input#protected_area_lat[name=?]", "protected_area[lat]"
      assert_select "input#protected_area_source_db[name=?]", "protected_area[source_db]"
    end
  end
end
