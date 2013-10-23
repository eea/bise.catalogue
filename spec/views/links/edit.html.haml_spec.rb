require 'spec_helper'

describe "links/edit" do

  before(:each) do
    @link = assign(:link, FactoryGirl.create(:link))
  end

  it "renders the edit link form" do
    render
    assert_select "form[action=?][method=?]", link_path(@link), "post"
  end

end
