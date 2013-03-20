require 'spec_helper'

describe "targets/edit" do
  before(:each) do
    @target = assign(:target, stub_model(Target,
      :title => "MyString",
      :short_desc => "MyString"
    ))
  end

  it "renders the edit target form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", target_path(@target), "post" do
      assert_select "input#target_title[name=?]", "target[title]"
      assert_select "input#target_short_desc[name=?]", "target[short_desc]"
    end
  end
end
