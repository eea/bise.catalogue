require 'spec_helper'

describe "actions/new" do
  before(:each) do
    assign(:action, stub_model(Action,
      :title => "MyString",
      :short_desc => "MyString",
      :target => nil
    ).as_new_record)
  end

  it "renders new action form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", actions_path, "post" do
      assert_select "input#action_title[name=?]", "action[title]"
      assert_select "input#action_short_desc[name=?]", "action[short_desc]"
      assert_select "input#action_target[name=?]", "action[target]"
    end
  end
end
