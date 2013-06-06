require 'spec_helper'

describe "ecosystem_assessments/index" do
  before(:each) do
    assign(:ecosystem_assessments, [
      stub_model(EcosystemAssessment,
        :type => "Type",
        :title => "Title",
        :language => "Language",
        :english_title => "English Title",
        :published_year => 1,
        :origin => "Origin",
        :url => "Url",
        :is_final => false,
        :license => "License"
      ),
      stub_model(EcosystemAssessment,
        :type => "Type",
        :title => "Title",
        :language => "Language",
        :english_title => "English Title",
        :published_year => 1,
        :origin => "Origin",
        :url => "Url",
        :is_final => false,
        :license => "License"
      )
    ])
  end

  it "renders a list of ecosystem_assessments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "English Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Origin".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "License".to_s, :count => 2
  end
end
