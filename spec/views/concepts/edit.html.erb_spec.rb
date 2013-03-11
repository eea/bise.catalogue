require 'spec_helper'

describe "concepts/edit" do
  before(:each) do
    @concept = assign(:concept, stub_model(Concept,
      :title => "MyString",
      :parent => 1,
      :definition => "MyString"
    ))
  end

  it "renders the edit concept form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => concepts_path(@concept), :method => "post" do
      assert_select "input#concept_title", :name => "concept[title]"
      assert_select "input#concept_parent", :name => "concept[parent]"
      assert_select "input#concept_definition", :name => "concept[definition]"
    end
  end
end
