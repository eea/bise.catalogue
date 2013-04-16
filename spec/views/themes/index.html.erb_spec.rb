require 'spec_helper'

describe "themes/index" do
  before(:each) do
    assign(:themes, [
      stub_model(Theme,
        :title => "Title"
      ),
      stub_model(Theme,
        :title => "Title"
      )
    ])
  end

  it "renders a list of themes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
