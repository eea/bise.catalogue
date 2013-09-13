class CreateDocuments < ActiveRecord::Migration

  def change
    create_table :documents do |t|

      t.string      :title
      t.string      :english_title
      t.string      :author
      t.text        :description

      t.string      :language
      # t.text        :geographical_coverage
      t.text        :biographical_region

      t.string      :source_url

      t.date        :published_on
      t.boolean     :published

      t.boolean     :approved, default: false

      t.integer     :downloads
      t.string      :file
      t.string      :content_type
      t.float       :file_size
      t.string      :md5hash

      t.references  :site
      t.references  :theme

      t.timestamps

    end
  end

end
