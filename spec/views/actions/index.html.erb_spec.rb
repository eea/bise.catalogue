require 'spec_helper'

describe "actions/index" do
  before(:each) do
    assign(:actions, [
      stub_model(Action,
        :title => "Title",
        :short_desc => "Short Desc",
        :target => nil
      ),
      stub_model(Action,
        :title => "Title",
        :short_desc => "Short Desc",
        :target => nil
      )
    ])
  end

  it "renders a list of actions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Short Desc".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
