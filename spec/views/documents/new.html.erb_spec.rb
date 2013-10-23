require 'spec_helper'

describe "documents/new" do
  before(:each) do
    assign(:document, stub_model(Document,
      :name => "MyString",
      :description => "MyString",
      :filename => "MyString",
      :author => "MyString",
      :downloads => 1
    ).as_new_record)
  end

  it "renders new document form" do
    render
    assert_select "form", action: documents_path, method: 'post'
  end
end
