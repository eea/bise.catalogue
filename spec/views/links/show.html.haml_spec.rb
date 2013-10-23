require 'spec_helper'

describe "links/show" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    @link = assign(:link, FactoryGirl.create(:link))
  end

  it "renders attributes in <p>" do
    render
  end

end
