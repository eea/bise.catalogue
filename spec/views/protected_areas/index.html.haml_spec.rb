require 'spec_helper'

describe "protected_areas/index" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    3.times { FactoryGirl.create(:protected_area) }
    assign(:protected_areas, ProtectedArea.search(query:''))
  end

  it "renders a list of protected_areas" do
    render
  end

end
