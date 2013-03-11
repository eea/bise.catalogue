require 'spec_helper'

describe "Concepts" do
  describe "GET /concepts" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get concepts_path
      response.status.should be(200)
    end
  end
end
