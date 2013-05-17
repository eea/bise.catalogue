require "spec_helper"

describe HabitatsController do
  describe "routing" do

    it "routes to #index" do
      get("/habitats").should route_to("habitats#index")
    end

    it "routes to #new" do
      get("/habitats/new").should route_to("habitats#new")
    end

    it "routes to #show" do
      get("/habitats/1").should route_to("habitats#show", :id => "1")
    end

    it "routes to #edit" do
      get("/habitats/1/edit").should route_to("habitats#edit", :id => "1")
    end

    it "routes to #create" do
      post("/habitats").should route_to("habitats#create")
    end

    it "routes to #update" do
      put("/habitats/1").should route_to("habitats#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/habitats/1").should route_to("habitats#destroy", :id => "1")
    end

  end
end
