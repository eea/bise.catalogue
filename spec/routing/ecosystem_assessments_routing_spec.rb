require "spec_helper"

describe EcosystemAssessmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/ecosystem_assessments").should route_to("ecosystem_assessments#index")
    end

    it "routes to #new" do
      get("/ecosystem_assessments/new").should route_to("ecosystem_assessments#new")
    end

    it "routes to #show" do
      get("/ecosystem_assessments/1").should route_to("ecosystem_assessments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ecosystem_assessments/1/edit").should route_to("ecosystem_assessments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ecosystem_assessments").should route_to("ecosystem_assessments#create")
    end

    it "routes to #update" do
      put("/ecosystem_assessments/1").should route_to("ecosystem_assessments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ecosystem_assessments/1").should route_to("ecosystem_assessments#destroy", :id => "1")
    end

  end
end
