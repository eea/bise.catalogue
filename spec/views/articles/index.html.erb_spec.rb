require 'spec_helper'

describe "articles/index" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    3.times { FactoryGirl.create(:article) }
    assign(:articles, Article.search(query:''))
  end

  it "renders a list of articles" do
    render
  end

end
