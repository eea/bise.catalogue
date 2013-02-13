class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|

      t.string    :title
      t.text      :content
      t.text      :author
      t.text      :source_url
      t.date      :published_on

      t.boolean   :published

      t.timestamps

    end
  end
end
