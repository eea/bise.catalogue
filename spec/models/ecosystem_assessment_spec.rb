require 'spec_helper'

describe EcosystemAssessment do

  before do
    @ecosystem_assessment = FactoryGirl.create(:ecosystem_assessment)
  end

  it "should be valid" do
    @ecosystem_assessment.should be_valid
  end

end
