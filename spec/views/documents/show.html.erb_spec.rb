require 'spec_helper'

describe "documents/show" do
  before(:each) do
    @document = assign(:document, stub_model(Document,
      :name => "Name",
      :description => "Description",
      :filename => "Filename",
      :author => "Author",
      :downloads => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(/Filename/)
    rendered.should match(/Author/)
    rendered.should match(/1/)
  end
end
