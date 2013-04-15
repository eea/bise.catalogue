require 'spec_helper'

describe "articles/new" do
  before(:each) do
    assign(:article, stub_model(Article).as_new_record)
  end

  it "renders new article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articles_path, :method => "post" do
    end
  end
end
