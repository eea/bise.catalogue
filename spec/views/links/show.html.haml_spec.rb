require 'spec_helper'

describe "links/show" do
  before(:each) do
    @link = assign(:link, stub_model(Link,
      :title => "Title",
      :english_title => "English Title",
      :author => "Author",
      :language => "Language",
      :source => "Source",
      :approved => false,
      :countries => nil,
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/English Title/)
    rendered.should match(/Author/)
    rendered.should match(/Language/)
    rendered.should match(/Source/)
    rendered.should match(/false/)
    rendered.should match(//)
    rendered.should match(/Url/)
  end
end
