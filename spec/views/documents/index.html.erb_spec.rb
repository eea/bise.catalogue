require 'spec_helper'

describe "documents/index" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    view.stub(:current_user).and_return(@user)
    FactoryGirl.create(:document)
    FactoryGirl.create(:other_document)
    assign(:documents, Document.search(query: ''))
  end

  it "renders a list of documents" do
    render
  end

end
