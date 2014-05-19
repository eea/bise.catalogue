class CreateCatalogueSearches < ActiveRecord::Migration
  def change
    create_table :catalogue_searches do |t|
      t.string :query
      t.integer :page
      t.integer :per
      t.boolean :document
      t.boolean :webpage
      t.boolean :link
      t.boolean :protected_site
      t.boolean :habitat
      t.boolean :species
      t.date :start_date
      t.date :end_date
      t.string :site
      t.string :source_db
      t.string :countries
      t.string :languages
      t.string :biographical_region
      t.string :species_group
      t.string :taxonomic_rank
      t.string :genus

      t.timestamps
    end
  end
end
