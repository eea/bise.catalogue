class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.text       :title
      t.text       :english_title

      t.text       :author
      t.text       :content

      t.string     :language
      t.text       :biographical_region

      t.string     :source_url

      t.date       :published_on
      t.boolean    :published, default: false
      t.boolean    :approved , default: false
      t.date       :approved_at

      t.references :site
      t.references :creator, index: true
      t.references :modifier, index: true

      t.string     :url
      t.text       :description
      t.timestamps
    end

    create_table :graphs_countries, :id => false do |t|
        t.integer :graph_id
        t.integer :country_id
    end

    create_table :graphs_languages, :id => false do |t|
        t.integer :graph_id
        t.integer :language_id
    end

  end
end
