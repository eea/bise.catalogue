require 'spec_helper'

describe "news/index" do
  before(:each) do
    assign(:news, [
      stub_model(News,
        :approved => "Approved",
        :approved_at => "Approved At",
        :author => "Author",
        :english_title => "English Title",
        :language => "Language",
        :published_on => "Published On",
        :source => "Source",
        :title => "Title",
        :url => "Url",
        :description => "Description",
        :comment => "Comment",
        :published => "Published"
      ),
      stub_model(News,
        :approved => "Approved",
        :approved_at => "Approved At",
        :author => "Author",
        :english_title => "English Title",
        :language => "Language",
        :published_on => "Published On",
        :source => "Source",
        :title => "Title",
        :url => "Url",
        :description => "Description",
        :comment => "Comment",
        :published => "Published"
      )
    ])
  end

  it "renders a list of news" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Approved".to_s, :count => 2
    assert_select "tr>td", :text => "Approved At".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "English Title".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "Published On".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => "Published".to_s, :count => 2
  end
end
