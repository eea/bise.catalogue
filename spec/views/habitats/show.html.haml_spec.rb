require 'spec_helper'

describe "habitats/show" do
  before(:each) do
    @habitat = assign(:habitat, stub_model(Habitat,
      :uri => "Uri",
      :code => 1,
      :name => "Name",
      :natura2000_code => 2,
      :habitat_code => "Habitat Code",
      :level => 3,
      :originally_published_code => 4,
      :description => "Description",
      :comment => "Comment",
      :national_name => "National Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Uri/)
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/2/)
    rendered.should match(/Habitat Code/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/Description/)
    rendered.should match(/Comment/)
    rendered.should match(/National Name/)
  end
end
