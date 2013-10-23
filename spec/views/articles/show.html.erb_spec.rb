require 'spec_helper'

describe "articles/show" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    @article = assign(:article, FactoryGirl.create(:article))
  end

  it "renders attributes in <p>" do
    render
  end
end
