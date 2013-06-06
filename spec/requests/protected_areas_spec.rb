require 'spec_helper'

describe "ProtectedAreas" do
  describe "GET /protected_areas" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get protected_areas_path
      response.status.should be(200)
    end
  end
end
