require 'spec_helper'

describe "ecosystem_assessments/show" do
  before(:each) do
    @ecosystem_assessment = assign(:ecosystem_assessment, stub_model(EcosystemAssessment,
      :type => "Type",
      :title => "Title",
      :language => "Language",
      :english_title => "English Title",
      :published_year => 1,
      :origin => "Origin",
      :url => "Url",
      :is_final => false,
      :license => "License"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
    rendered.should match(/Title/)
    rendered.should match(/Language/)
    rendered.should match(/English Title/)
    rendered.should match(/1/)
    rendered.should match(/Origin/)
    rendered.should match(/Url/)
    rendered.should match(/false/)
    rendered.should match(/License/)
  end
end
