require 'spec_helper'

describe "protected_areas/show" do
  before(:each) do
    @protected_area = assign(:protected_area, stub_model(ProtectedArea,
      :code => 1,
      :uri => "Uri",
      :name => "Name",
      :designation_year => 2,
      :nuts_code => "Nuts Code",
      :area => "",
      :length => "",
      :long => "",
      :lat => "",
      :source_db => "Source Db"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Uri/)
    rendered.should match(/Name/)
    rendered.should match(/2/)
    rendered.should match(/Nuts Code/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Source Db/)
  end
end
