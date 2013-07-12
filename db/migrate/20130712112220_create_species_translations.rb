class CreateSpeciesTranslations < ActiveRecord::Migration
  def change
    create_table :species_translations do |t|
      t.string :locale
      t.string :name
      t.references :species

      t.timestamps
    end
    add_index :species_translations, :species_id
  end
end
