require "spec_helper"

describe ProtectedAreasController do
  describe "routing" do

    it "routes to #index" do
      get("/protected_areas").should route_to("protected_areas#index")
    end

    it "routes to #new" do
      get("/protected_areas/new").should route_to("protected_areas#new")
    end

    it "routes to #show" do
      get("/protected_areas/1").should route_to("protected_areas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/protected_areas/1/edit").should route_to("protected_areas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/protected_areas").should route_to("protected_areas#create")
    end

    it "routes to #update" do
      put("/protected_areas/1").should route_to("protected_areas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/protected_areas/1").should route_to("protected_areas#destroy", :id => "1")
    end

  end
end
