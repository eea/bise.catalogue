require 'spec_helper'

describe HomeController do

  let(:user) do
    FactoryGirl.create(:user)
  end

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
