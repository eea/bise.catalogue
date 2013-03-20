require "spec_helper"

describe TargetsController do
  describe "routing" do

    it "routes to #index" do
      get("/targets").should route_to("targets#index")
    end

    it "routes to #new" do
      get("/targets/new").should route_to("targets#new")
    end

    it "routes to #show" do
      get("/targets/1").should route_to("targets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/targets/1/edit").should route_to("targets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/targets").should route_to("targets#create")
    end

    it "routes to #update" do
      put("/targets/1").should route_to("targets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/targets/1").should route_to("targets#destroy", :id => "1")
    end

  end
end
