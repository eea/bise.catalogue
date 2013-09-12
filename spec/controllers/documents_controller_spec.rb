require 'spec_helper'

describe DocumentsController do

  include CarrierWave::Test::Matchers

  let(:user) do
    FactoryGirl.create(:user)
  end

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
    # @document = FactoryGirl.create(:document)
  end

  # after :each do
  #   @document.destroy
  # end

  # def valid_attributes
  #   {
  #     site_id: 1,
  #     title: 'Titulo de Ejemplo',
  #     english_title: 'Example Title',
  #     author: 'Jon Arrien',
  #     # file: File.read(File.join(Rails.root, '/spec/fixtures/files/IT_Biodiversity.pdf')),
  #     # file: File.open(File.join(Rails.root, '/spec/fixtures/files/NL_Biodiversity.pdf'),'rb'),
  #     # file: File.join(Rails.root, '/spec/fixtures/files/NL_Biodiversity.pdf'),
  #     file: File.join(Rails.root, '/spec/fixtures/files/IT_Biodiversity.pdf'),
  #     # remote_file_url: "http://www.eea.europa.eu/publications/biodiversity-monitoring-in-europe/at_download/file",
  #     language_ids: [5],
  #     published_on: '01/01/2013'
  #   }
  # end

  describe "GET index" do
    it "assigns all documents as @documents" do
      get :index, {}
      # assigns(:documents).should eq([@document])
      assigns(:documents).should be_a(Tire::Results::Collection)
    end
  end

  describe "GET show" do
    it "assigns the requested document as @document" do
      doc = FactoryGirl.create(:document)
      get :show, {:id => doc.to_param}
      assigns(:document).should eq(doc)
    end
  end

  describe "GET new" do
    it "assigns a new document as @document" do
      get :new, {}
      assigns(:document).should be_a_new(Document)
    end
  end

  describe "GET edit" do
    it "assigns the requested document as @document" do
      doc = FactoryGirl.create(:document)
      get :edit, {:id => doc.to_param}
      assigns(:document).should eq(doc)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Document" do
        expect {
          post :create, { document: FactoryGirl.build(:other_document).attributes }
        }.to change(Document, :count).by(1)
      end

      it "assigns a newly created document as @document" do
        post :create, { :document => FactoryGirl.build(:other_document).attributes }
        assigns(:document).should be_a(Document)
        assigns(:document).should be_persisted
      end

      it "redirects to the created document" do
        # doc = FactoryGirl.create :document
        p ":: needs to redirect..."
        # p FactoryGirl.build(:other_document).attributes
        post :create, { :document => FactoryGirl.build(:other_document).attributes }
        response.should redirect_to(Document.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved document as @document" do
        # Trigger the behavior that occurs when invalid params are submitted
        Document.any_instance.stub(:save).and_return(false)
        post :create, {:document => {}}
        assigns(:document).should be_a_new(Document)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Document.any_instance.stub(:save).and_return(false)
        post :create, {:document => {}}
        response.should render_template("new")
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested document" do
  #       # Assuming there are no other documents in the database, this
  #       # specifies that the Document created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       Document.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, {:id => @document.to_param, :document => {'these' => 'params'}}
  #     end

  #     it "assigns the requested document as @document" do
  #       # document = Document.create! FactoryGirl.create(:document)
  #       put :update, {:id => document.to_param, :document => FactoryGirl.create(:document) }
  #       assigns(:document).should eq(@document)
  #     end

  #     it "redirects to the document" do
  #       # document = Document.create! FactoryGirl.create(:document)
  #       put :update, {:id => @document.to_param, :document => FactoryGirl.create(:document) }
  #       response.should redirect_to(@document)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the document as @document" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Document.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => @document.to_param, :document => {}}
  #       assigns(:document).should eq(@document)
  #     end

  #     it "re-renders the 'edit' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Document.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => @document.to_param, :document => {}}
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested document" do
  #     document = Document.create! FactoryGirl.create(:document)
  #     expect {
  #       delete :destroy, {:id => document.to_param}
  #     }.to change(Document, :count).by(-1)
  #   end

  #   it "redirects to the documents list" do
  #     document = Document.create! FactoryGirl.create(:document)
  #     delete :destroy, {:id => document.to_param}
  #     response.should redirect_to(documents_url)
  #   end
  # end

end
