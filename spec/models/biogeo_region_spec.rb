require 'spec_helper'

describe BiogeoRegion do

  before do
    @biogeoregion = FactoryGirl.create(:biogeo_region)
  end

  it "should be valid" do
    should be_valid
  end

end
