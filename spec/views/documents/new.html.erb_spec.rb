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

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => documents_path, :method => "post" do
      assert_select "input#document_name", :name => "document[name]"
      assert_select "input#document_description", :name => "document[description]"
      assert_select "input#document_filename", :name => "document[filename]"
      assert_select "input#document_author", :name => "document[author]"
      assert_select "input#document_downloads", :name => "document[downloads]"
    end
  end
end
