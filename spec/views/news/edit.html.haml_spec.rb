require 'spec_helper'

describe "news/edit" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    pending "news views"
    # @news = assign(:news, FactoryGirl.create(:news))
  end

  it "renders the edit news form" do
    # render
    pending 'news#edit'
  end

end
