require 'spec_helper'

describe "sites/index" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    FactoryGirl.create(:site, id: 101)
    FactoryGirl.create(:site, id: 102)
    assign(:sites, Site.all)
  end

  it "renders a list of sites" do
    render
  end

end
