class CreateLinks < ActiveRecord::Migration

  def change
    create_table :links do |t|

      t.string     :title
      t.string     :english_title
      t.string     :author

      t.string     :language
      t.text       :biographical_region

      t.string     :url
      t.text       :description

      t.date       :published_on
      t.boolean    :published, default: false

      t.boolean    :approved , default: false
      t.date       :approved_at

      t.references :site
      t.timestamps

      # t.string     :source
      # t.string     :comment

    end
  end

end
