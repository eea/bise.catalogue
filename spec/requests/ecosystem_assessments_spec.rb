require 'spec_helper'

describe "EcosystemAssessments" do
  describe "GET /ecosystem_assessments" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get ecosystem_assessments_path
      response.status.should be(200)
    end
  end
end
