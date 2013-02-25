require 'spec_helper'

describe "species/index" do
  before(:each) do
    assign(:species, [
      stub_model(Specie,
        :species_code => 1,
        :binomial_name => "Binomial Name",
        :valid_name => "Valid Name",
        :eunis_primary_name => "Eunis Primary Name",
        :synonym_for => "Synonym For",
        :taxonomic_rank => "Taxonomic Rank",
        :taxonomy => "Taxonomy",
        :scientific_name_authorship => "Scientific Name Authorship",
        :scientific_name => "Scientific Name",
        :label => "Label",
        :genus => "Genus",
        :species_group => "Species Group",
        :name_according_to_ID => "Name According To",
        :ignore_on_match => false
      ),
      stub_model(Specie,
        :species_code => 1,
        :binomial_name => "Binomial Name",
        :valid_name => "Valid Name",
        :eunis_primary_name => "Eunis Primary Name",
        :synonym_for => "Synonym For",
        :taxonomic_rank => "Taxonomic Rank",
        :taxonomy => "Taxonomy",
        :scientific_name_authorship => "Scientific Name Authorship",
        :scientific_name => "Scientific Name",
        :label => "Label",
        :genus => "Genus",
        :species_group => "Species Group",
        :name_according_to_ID => "Name According To",
        :ignore_on_match => false
      )
    ])
  end

  it "renders a list of species" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Binomial Name".to_s, :count => 2
    assert_select "tr>td", :text => "Valid Name".to_s, :count => 2
    assert_select "tr>td", :text => "Eunis Primary Name".to_s, :count => 2
    assert_select "tr>td", :text => "Synonym For".to_s, :count => 2
    assert_select "tr>td", :text => "Taxonomic Rank".to_s, :count => 2
    assert_select "tr>td", :text => "Taxonomy".to_s, :count => 2
    assert_select "tr>td", :text => "Scientific Name Authorship".to_s, :count => 2
    assert_select "tr>td", :text => "Scientific Name".to_s, :count => 2
    assert_select "tr>td", :text => "Label".to_s, :count => 2
    assert_select "tr>td", :text => "Genus".to_s, :count => 2
    assert_select "tr>td", :text => "Species Group".to_s, :count => 2
    assert_select "tr>td", :text => "Name According To".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
