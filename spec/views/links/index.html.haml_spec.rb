require 'spec_helper'

describe "links/index" do
  before(:each) do
    assign(:links, [
      stub_model(Link,
        :title => "Title",
        :english_title => "English Title",
        :author => "Author",
        :language => "Language",
        :source => "Source",
        :approved => false,
        :countries => nil,
        :url => "Url"
      ),
      stub_model(Link,
        :title => "Title",
        :english_title => "English Title",
        :author => "Author",
        :language => "Language",
        :source => "Source",
        :approved => false,
        :countries => nil,
        :url => "Url"
      )
    ])
  end

  it "renders a list of links" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "English Title".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
