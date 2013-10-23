require 'spec_helper'

describe LinksController do

  let(:user) do
    FactoryGirl.create(:user)
  end

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
    @link = FactoryGirl.create :link
  end

  def valid_attributes
    {
      site_id: 1,
      title: 'Link title',
      english_title: 'English link title',
      author: 'Jon Arrien',
      published_on: '2013-04-30 11:25:37',
      language_ids: [22,5],
      url: 'http://www.example.org',
      approved: false,
      approved_at: '2013-04-30 11:25:37'
    }
  end

  describe "GET index" do
    it "assigns all links as @links" do
      links = Link.search({ query:'' })
      get :index, {}
      assigns(:links).should be_a(Tire::Results::Collection)
    end
  end

  describe "GET show" do
    it "assigns the requested link as @link" do
      get :show, {:id => @link.to_param}
      assigns(:link).should eq(@link)
    end
  end

  describe "GET new" do
    it "assigns a new link as @link" do
      get :new, {}
      assigns(:link).should be_a_new(Link)
    end
  end

  describe "GET edit" do
    it "assigns the requested link as @link" do
      get :edit, {:id => @link.to_param}
      assigns(:link).should eq(@link)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Link" do
        expect {
          post :create, {:link => valid_attributes}
        }.to change(Link, :count).by(1)
      end

      it "assigns a newly created link as @link" do
        post :create, {:link => valid_attributes}
        assigns(:link).should be_a(Link)
        assigns(:link).should be_persisted
      end

      it "redirects to the created link" do
        post :create, {:link => valid_attributes}
        response.should redirect_to(Link.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved link as @link" do
        # Trigger the behavior that occurs when invalid params are submitted
        Link.any_instance.stub(:save).and_return(false)
        post :create, {:link => { "title" => "invalid value" }}
        assigns(:link).should be_a_new(Link)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Link.any_instance.stub(:save).and_return(false)
        post :create, {:link => { "title" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested link" do
        Link.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => @link.to_param, :link => { "title" => "MyString" }}
      end

      it "assigns the requested link as @link" do
        put :update, {:id => @link.to_param, :link => valid_attributes}
        assigns(:link).should eq(@link)
      end

      it "redirects to the link" do
        put :update, {:id => @link.to_param, :link => valid_attributes}
        response.should redirect_to(@link)
      end
    end

    describe "with invalid params" do
      it "assigns the link as @link" do
        Link.any_instance.stub(:save).and_return(false)
        put :update, {:id => @link.to_param, :link => { "title" => "invalid value" }}
        assigns(:link).should eq(@link)
      end

      it "re-renders the 'edit' template" do
        Link.any_instance.stub(:save).and_return(false)
        put :update, {:id => @link.to_param, :link => { "title" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested link" do
      expect {
        delete :destroy, {:id => @link.to_param}
      }.to change(Link, :count).by(-1)
    end

    it "redirects to the links list" do
      delete :destroy, {:id => @link.to_param}
      response.should redirect_to(links_url)
    end
  end

end
