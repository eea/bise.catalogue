require 'spec_helper'

describe "species/show" do
  before(:each) do
    @specie = assign(:specie, stub_model(Specie,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Binomial Name/)
    rendered.should match(/Valid Name/)
    rendered.should match(/Eunis Primary Name/)
    rendered.should match(/Synonym For/)
    rendered.should match(/Taxonomic Rank/)
    rendered.should match(/Taxonomy/)
    rendered.should match(/Scientific Name Authorship/)
    rendered.should match(/Scientific Name/)
    rendered.should match(/Label/)
    rendered.should match(/Genus/)
    rendered.should match(/Species Group/)
    rendered.should match(/Name According To/)
    rendered.should match(/false/)
  end
end
