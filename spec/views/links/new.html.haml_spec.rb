require 'spec_helper'

describe "links/new" do

  before(:each) do
    assign(:link, FactoryGirl.create(:link))
  end

  it "renders new link form" do
    render
    assert_select "form[action=?][method=?]", links_path, "post"
  end

end
