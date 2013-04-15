require 'spec_helper'

describe "concepts/new" do
  before(:each) do
    assign(:concept, stub_model(Concept,
      :title => "MyString",
      :parent => 1,
      :definition => "MyString"
    ).as_new_record)
  end

  it "renders new concept form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => concepts_path, :method => "post" do
      assert_select "input#concept_title", :name => "concept[title]"
      assert_select "input#concept_parent", :name => "concept[parent]"
      assert_select "input#concept_definition", :name => "concept[definition]"
    end
  end
end
