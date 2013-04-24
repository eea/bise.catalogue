class CreateEcosystemAssessments < ActiveRecord::Migration
  def change
    create_table :ecosystem_assessments do |t|
      t.string :document_type
      t.string :title
      t.string :language
      t.string :english_title
      t.integer :published_year
      t.string :origin
      t.string :url
      t.boolean :is_final
      t.string :license

      t.timestamps
    end
  end
end
