require 'spec_helper'

describe "actions/show" do
  before(:each) do
    @action = assign(:action, stub_model(Action,
      :title => "Title",
      :short_desc => "Short Desc",
      :target => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Short Desc/)
    rendered.should match(//)
  end
end
