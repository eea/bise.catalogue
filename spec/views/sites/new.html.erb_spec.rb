require 'spec_helper'

describe "sites/new" do

  before(:each) do
    assign(:site, stub_model(Site,
      :name => "MyString",
      :origin_url => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new site form" do
    render
    assert_select "form", action: sites_path, method: "post"
  end

end
