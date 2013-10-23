require 'spec_helper'

describe "Articles" do
  describe "GET /articles" do
    it "works! (now write some real specs)" do
      get articles_path
      response.status.should be(200)
    end
  end
end
