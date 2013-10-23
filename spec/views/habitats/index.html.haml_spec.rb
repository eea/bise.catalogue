require 'spec_helper'

describe "habitats/index" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    3.times { FactoryGirl.create(:habitat) }
    assign(:habitats, Habitat.search(query: ''))
  end

  it "renders a list of habitats" do
    render
  end

end
