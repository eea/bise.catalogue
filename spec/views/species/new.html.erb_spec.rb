require 'spec_helper'

describe "species/new" do
  before(:each) do
    assign(:specie, stub_model(Specie,
      :species_code => 1,
      :binomial_name => "MyString",
      :valid_name => "MyString",
      :eunis_primary_name => "MyString",
      :synonym_for => "MyString",
      :taxonomic_rank => "MyString",
      :taxonomy => "MyString",
      :scientific_name_authorship => "MyString",
      :scientific_name => "MyString",
      :label => "MyString",
      :genus => "MyString",
      :species_group => "MyString",
      :name_according_to_ID => "MyString",
      :ignore_on_match => false
    ).as_new_record)
  end

  it "renders new specie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => species_path, :method => "post" do
      assert_select "input#specie_species_code", :name => "specie[species_code]"
      assert_select "input#specie_binomial_name", :name => "specie[binomial_name]"
      assert_select "input#specie_valid_name", :name => "specie[valid_name]"
      assert_select "input#specie_eunis_primary_name", :name => "specie[eunis_primary_name]"
      assert_select "input#specie_synonym_for", :name => "specie[synonym_for]"
      assert_select "input#specie_taxonomic_rank", :name => "specie[taxonomic_rank]"
      assert_select "input#specie_taxonomy", :name => "specie[taxonomy]"
      assert_select "input#specie_scientific_name_authorship", :name => "specie[scientific_name_authorship]"
      assert_select "input#specie_scientific_name", :name => "specie[scientific_name]"
      assert_select "input#specie_label", :name => "specie[label]"
      assert_select "input#specie_genus", :name => "specie[genus]"
      assert_select "input#specie_species_group", :name => "specie[species_group]"
      assert_select "input#specie_name_according_to_ID", :name => "specie[name_according_to_ID]"
      assert_select "input#specie_ignore_on_match", :name => "specie[ignore_on_match]"
    end
  end
end
