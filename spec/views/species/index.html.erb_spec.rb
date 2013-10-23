require 'spec_helper'

describe "species/index" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    FactoryGirl.create(:species)
    FactoryGirl.create(:species, { uri: 'http://species/1' } )
    assign(:species, Species.search(query:''))
  end

  it "renders a list of species" do
    render
  end

end
