require 'spec_helper'

describe "targets/new" do
  before(:each) do
    assign(:target, stub_model(Target,
      :title => "MyString",
      :short_desc => "MyString"
    ).as_new_record)
  end

  it "renders new target form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", targets_path, "post" do
      assert_select "input#target_title[name=?]", "target[title]"
      assert_select "input#target_short_desc[name=?]", "target[short_desc]"
    end
  end
end
