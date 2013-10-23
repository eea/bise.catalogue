require 'spec_helper'

describe "species/show" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    @specie = assign(:specie, FactoryGirl.create(:species))
  end

  it "renders attributes in <p>" do
    render
  end

end
