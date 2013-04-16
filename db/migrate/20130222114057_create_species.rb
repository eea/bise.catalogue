class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.integer :species_code
      t.string :binomial_name
      t.string :valid_name
      t.string :eunis_primary_name
      t.string :synonym_for
      t.string :taxonomic_rank
      t.string :taxonomy
      t.string :scientific_name_authorship
      t.string :scientific_name
      t.string :label
      t.string :genus
      t.string :species_group
      t.string :name_according_to_ID
      t.boolean :ignore_on_match

      t.timestamps
    end
  end
end
