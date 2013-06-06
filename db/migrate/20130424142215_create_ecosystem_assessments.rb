class CreateEcosystemAssessments < ActiveRecord::Migration
  def change
    create_table :ecosystem_assessments do |t|
      t.string :resource_type
      t.string :title
      t.string :language
      t.string :english_title
      t.integer :published_year
      t.string :origin
      t.string :url
      t.boolean :is_final
      t.string :availability

      t.timestamps
    end
  end
end
