require 'spec_helper'

describe "habitats/edit" do
  before(:each) do
    @habitat = assign(:habitat, stub_model(Habitat,
      :uri => "MyString",
      :code => 1,
      :name => "MyString",
      :natura2000_code => 1,
      :habitat_code => "MyString",
      :level => 1,
      :originally_published_code => 1,
      :description => "MyString",
      :comment => "MyString",
      :national_name => "MyString"
    ))
  end

  it "renders the edit habitat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", habitat_path(@habitat), "post" do
      assert_select "input#habitat_uri[name=?]", "habitat[uri]"
      assert_select "input#habitat_code[name=?]", "habitat[code]"
      assert_select "input#habitat_name[name=?]", "habitat[name]"
      assert_select "input#habitat_natura2000_code[name=?]", "habitat[natura2000_code]"
      assert_select "input#habitat_habitat_code[name=?]", "habitat[habitat_code]"
      assert_select "input#habitat_level[name=?]", "habitat[level]"
      assert_select "input#habitat_originally_published_code[name=?]", "habitat[originally_published_code]"
      assert_select "input#habitat_description[name=?]", "habitat[description]"
      assert_select "input#habitat_comment[name=?]", "habitat[comment]"
      assert_select "input#habitat_national_name[name=?]", "habitat[national_name]"
    end
  end
end
