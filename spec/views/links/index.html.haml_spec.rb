require 'spec_helper'

describe "links/index" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    3.times { FactoryGirl.create(:link) }
    assign(:links, Link.search(query: ''))
  end

  it "renders a list of links" do
    render
  end

end
