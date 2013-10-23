require 'spec_helper'

describe EcosystemAssessmentsController do

  pending "Waiting feedback from client"

  # def valid_attributes
  #   { "type" => "" }
  # end

  # def valid_session
  #   {}
  # end

  # describe "GET index" do
  #   it "assigns all ecosystem_assessments as @ecosystem_assessments" do
  #     ecosystem_assessment = EcosystemAssessment.create! valid_attributes
  #     get :index, {}, valid_session
  #     assigns(:ecosystem_assessments).should eq([ecosystem_assessment])
  #   end
  # end

  # describe "GET show" do
  #   it "assigns the requested ecosystem_assessment as @ecosystem_assessment" do
  #     ecosystem_assessment = EcosystemAssessment.create! valid_attributes
  #     get :show, {:id => ecosystem_assessment.to_param}, valid_session
  #     assigns(:ecosystem_assessment).should eq(ecosystem_assessment)
  #   end
  # end

  # describe "GET new" do
  #   it "assigns a new ecosystem_assessment as @ecosystem_assessment" do
  #     get :new, {}, valid_session
  #     assigns(:ecosystem_assessment).should be_a_new(EcosystemAssessment)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested ecosystem_assessment as @ecosystem_assessment" do
  #     ecosystem_assessment = EcosystemAssessment.create! valid_attributes
  #     get :edit, {:id => ecosystem_assessment.to_param}, valid_session
  #     assigns(:ecosystem_assessment).should eq(ecosystem_assessment)
  #   end
  # end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new EcosystemAssessment" do
  #       expect {
  #         post :create, {:ecosystem_assessment => valid_attributes}, valid_session
  #       }.to change(EcosystemAssessment, :count).by(1)
  #     end

  #     it "assigns a newly created ecosystem_assessment as @ecosystem_assessment" do
  #       post :create, {:ecosystem_assessment => valid_attributes}, valid_session
  #       assigns(:ecosystem_assessment).should be_a(EcosystemAssessment)
  #       assigns(:ecosystem_assessment).should be_persisted
  #     end

  #     it "redirects to the created ecosystem_assessment" do
  #       post :create, {:ecosystem_assessment => valid_attributes}, valid_session
  #       response.should redirect_to(EcosystemAssessment.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved ecosystem_assessment as @ecosystem_assessment" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       EcosystemAssessment.any_instance.stub(:save).and_return(false)
  #       post :create, {:ecosystem_assessment => { "type" => "invalid value" }}, valid_session
  #       assigns(:ecosystem_assessment).should be_a_new(EcosystemAssessment)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       EcosystemAssessment.any_instance.stub(:save).and_return(false)
  #       post :create, {:ecosystem_assessment => { "type" => "invalid value" }}, valid_session
  #       response.should render_template("new")
  #     end
  #   end
  # end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested ecosystem_assessment" do
  #       ecosystem_assessment = EcosystemAssessment.create! valid_attributes
  #       # Assuming there are no other ecosystem_assessments in the database, this
  #       # specifies that the EcosystemAssessment created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       EcosystemAssessment.any_instance.should_receive(:update_attributes).with({ "type" => "" })
  #       put :update, {:id => ecosystem_assessment.to_param, :ecosystem_assessment => { "type" => "" }}, valid_session
  #     end

  #     it "assigns the requested ecosystem_assessment as @ecosystem_assessment" do
  #       ecosystem_assessment = EcosystemAssessment.create! valid_attributes
  #       put :update, {:id => ecosystem_assessment.to_param, :ecosystem_assessment => valid_attributes}, valid_session
  #       assigns(:ecosystem_assessment).should eq(ecosystem_assessment)
  #     end

  #     it "redirects to the ecosystem_assessment" do
  #       ecosystem_assessment = EcosystemAssessment.create! valid_attributes
  #       put :update, {:id => ecosystem_assessment.to_param, :ecosystem_assessment => valid_attributes}, valid_session
  #       response.should redirect_to(ecosystem_assessment)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the ecosystem_assessment as @ecosystem_assessment" do
  #       ecosystem_assessment = EcosystemAssessment.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       EcosystemAssessment.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => ecosystem_assessment.to_param, :ecosystem_assessment => { "type" => "invalid value" }}, valid_session
  #       assigns(:ecosystem_assessment).should eq(ecosystem_assessment)
  #     end

  #     it "re-renders the 'edit' template" do
  #       ecosystem_assessment = EcosystemAssessment.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       EcosystemAssessment.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => ecosystem_assessment.to_param, :ecosystem_assessment => { "type" => "invalid value" }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested ecosystem_assessment" do
  #     ecosystem_assessment = EcosystemAssessment.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => ecosystem_assessment.to_param}, valid_session
  #     }.to change(EcosystemAssessment, :count).by(-1)
  #   end

  #   it "redirects to the ecosystem_assessments list" do
  #     ecosystem_assessment = EcosystemAssessment.create! valid_attributes
  #     delete :destroy, {:id => ecosystem_assessment.to_param}, valid_session
  #     response.should redirect_to(ecosystem_assessments_url)
  #   end
  # end

end
