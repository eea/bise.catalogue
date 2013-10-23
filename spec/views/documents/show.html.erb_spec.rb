require 'spec_helper'

describe "documents/show" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    @document = assign(:document, FactoryGirl.create(:document))
  end

  it "renders attributes in <p>" do
    render
  end

end
