require 'spec_helper'

describe "ecosystem_assessments/edit" do
  before(:each) do
    @ecosystem_assessment = assign(:ecosystem_assessment, stub_model(EcosystemAssessment,
      :type => "",
      :title => "MyString",
      :language => "MyString",
      :english_title => "MyString",
      :published_year => 1,
      :origin => "MyString",
      :url => "MyString",
      :is_final => false,
      :license => "MyString"
    ))
  end

  it "renders the edit ecosystem_assessment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ecosystem_assessment_path(@ecosystem_assessment), "post" do
      assert_select "input#ecosystem_assessment_type[name=?]", "ecosystem_assessment[type]"
      assert_select "input#ecosystem_assessment_title[name=?]", "ecosystem_assessment[title]"
      assert_select "input#ecosystem_assessment_language[name=?]", "ecosystem_assessment[language]"
      assert_select "input#ecosystem_assessment_english_title[name=?]", "ecosystem_assessment[english_title]"
      assert_select "input#ecosystem_assessment_published_year[name=?]", "ecosystem_assessment[published_year]"
      assert_select "input#ecosystem_assessment_origin[name=?]", "ecosystem_assessment[origin]"
      assert_select "input#ecosystem_assessment_url[name=?]", "ecosystem_assessment[url]"
      assert_select "input#ecosystem_assessment_is_final[name=?]", "ecosystem_assessment[is_final]"
      assert_select "input#ecosystem_assessment_license[name=?]", "ecosystem_assessment[license]"
    end
  end
end
