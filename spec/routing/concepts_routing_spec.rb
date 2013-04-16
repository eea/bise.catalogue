require "spec_helper"

describe ConceptsController do
  describe "routing" do

    it "routes to #index" do
      get("/concepts").should route_to("concepts#index")
    end

    it "routes to #new" do
      get("/concepts/new").should route_to("concepts#new")
    end

    it "routes to #show" do
      get("/concepts/1").should route_to("concepts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/concepts/1/edit").should route_to("concepts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/concepts").should route_to("concepts#create")
    end

    it "routes to #update" do
      put("/concepts/1").should route_to("concepts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/concepts/1").should route_to("concepts#destroy", :id => "1")
    end

  end
end
