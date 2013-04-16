require 'spec_helper'

describe "concepts/index" do
  before(:each) do
    assign(:concepts, [
      stub_model(Concept,
        :title => "Title",
        :parent => 1,
        :definition => "Definition"
      ),
      stub_model(Concept,
        :title => "Title",
        :parent => 1,
        :definition => "Definition"
      )
    ])
  end

  it "renders a list of concepts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Definition".to_s, :count => 2
  end
end
