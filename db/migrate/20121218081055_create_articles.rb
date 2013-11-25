class CreateArticles < ActiveRecord::Migration

  def change
    create_table :articles do |t|

      t.string    :title
      t.string    :english_title
      t.text      :author
      t.text      :content

      t.string    :language
      # t.text      :geographical_coverage
      t.text      :biographical_region

      t.text      :source_url

      t.date      :published_on
      t.boolean   :published    , default: false

      t.references :site

      t.timestamps

    end
  end

end
