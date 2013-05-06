require 'spec_helper'

describe "news/show" do
  before(:each) do
    @news = assign(:news, stub_model(News,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Approved/)
    rendered.should match(/Approved At/)
    rendered.should match(/Author/)
    rendered.should match(/English Title/)
    rendered.should match(/Language/)
    rendered.should match(/Published On/)
    rendered.should match(/Source/)
    rendered.should match(/Title/)
    rendered.should match(/Url/)
    rendered.should match(/Description/)
    rendered.should match(/Comment/)
    rendered.should match(/Published/)
  end
end
