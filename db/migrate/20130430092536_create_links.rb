class CreateLinks < ActiveRecord::Migration

  def change
    create_table :links do |t|
      t.string     :title
      t.string     :english_title
      t.string     :author
      t.date       :published_on
      t.boolean    :published, default: false
      t.string     :language
      t.string     :source
      t.boolean    :approved , default: false
      t.text       :biographical_region
      t.string     :url
      t.string     :comment
      t.string     :description
      t.date       :approved_at
      t.references :site
      t.timestamps
    end
  end

end
