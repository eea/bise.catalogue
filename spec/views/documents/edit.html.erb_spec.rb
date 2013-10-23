require 'spec_helper'

describe "documents/edit" do
  before(:each) do
    @document = assign(:document, stub_model(Document,
      :name => "MyString",
      :description => "MyString",
      :filename => "MyString",
      :author => "MyString",
      :downloads => 1
    ))
  end

  it "renders the edit document form" do
    render
    assert_select "form", action: documents_path(@document), method: "post"
  end
end
