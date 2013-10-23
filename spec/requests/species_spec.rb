require 'spec_helper'

describe "Species" do
  describe "GET /species" do
    it "works! (now write some real specs)" do
      get species_path
      response.status.should be(200)
    end
  end
end
