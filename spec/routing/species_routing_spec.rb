require "spec_helper"

describe SpeciesController do
  describe "routing" do

    it "routes to #index" do
      get("/species").should route_to("species#index")
    end

    it "routes to #new" do
      get("/species/new").should route_to("species#new")
    end

    it "routes to #show" do
      get("/species/1").should route_to("species#show", :id => "1")
    end

    it "routes to #edit" do
      get("/species/1/edit").should route_to("species#edit", :id => "1")
    end

    it "routes to #create" do
      post("/species").should route_to("species#create")
    end

    it "routes to #update" do
      put("/species/1").should route_to("species#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/species/1").should route_to("species#destroy", :id => "1")
    end

  end
end
