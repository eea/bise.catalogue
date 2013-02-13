class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|

      t.string      :name
      t.string      :description
      t.string      :author
      t.string      :source_url
      t.integer     :downloads
      t.date        :published_on

      t.boolean     :published

      t.string      :file
      t.string      :content_type
      t.float       :file_size
      t.string      :md5hash

      t.timestamps

    end
  end
end
