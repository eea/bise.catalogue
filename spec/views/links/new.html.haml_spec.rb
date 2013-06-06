require 'spec_helper'

describe "links/new" do
  before(:each) do
    assign(:link, stub_model(Link,
      :title => "MyString",
      :english_title => "MyString",
      :author => "MyString",
      :language => "MyString",
      :source => "MyString",
      :approved => false,
      :countries => nil,
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", links_path, "post" do
      assert_select "input#link_title[name=?]", "link[title]"
      assert_select "input#link_english_title[name=?]", "link[english_title]"
      assert_select "input#link_author[name=?]", "link[author]"
      assert_select "input#link_language[name=?]", "link[language]"
      assert_select "input#link_source[name=?]", "link[source]"
      assert_select "input#link_approved[name=?]", "link[approved]"
      assert_select "input#link_countries[name=?]", "link[countries]"
      assert_select "input#link_url[name=?]", "link[url]"
    end
  end
end
