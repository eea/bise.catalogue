require 'spec_helper'

describe "news/edit" do
  before(:each) do
    @news = assign(:news, stub_model(News,
      :approved => "MyString",
      :approved_at => "MyString",
      :author => "MyString",
      :english_title => "MyString",
      :language => "MyString",
      :published_on => "MyString",
      :source => "MyString",
      :title => "MyString",
      :url => "MyString",
      :description => "MyString",
      :comment => "MyString",
      :published => "MyString"
    ))
  end

  it "renders the edit news form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", news_path(@news), "post" do
      assert_select "input#news_approved[name=?]", "news[approved]"
      assert_select "input#news_approved_at[name=?]", "news[approved_at]"
      assert_select "input#news_author[name=?]", "news[author]"
      assert_select "input#news_english_title[name=?]", "news[english_title]"
      assert_select "input#news_language[name=?]", "news[language]"
      assert_select "input#news_published_on[name=?]", "news[published_on]"
      assert_select "input#news_source[name=?]", "news[source]"
      assert_select "input#news_title[name=?]", "news[title]"
      assert_select "input#news_url[name=?]", "news[url]"
      assert_select "input#news_description[name=?]", "news[description]"
      assert_select "input#news_comment[name=?]", "news[comment]"
      assert_select "input#news_published[name=?]", "news[published]"
    end
  end
end
