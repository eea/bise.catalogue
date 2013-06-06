require 'spec_helper'

describe "targets/index" do
  before(:each) do
    assign(:targets, [
      stub_model(Target,
        :title => "Title",
        :short_desc => "Short Desc"
      ),
      stub_model(Target,
        :title => "Title",
        :short_desc => "Short Desc"
      )
    ])
  end

  it "renders a list of targets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Short Desc".to_s, :count => 2
  end
end
