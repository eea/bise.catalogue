# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Rails::Helper
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  include CarrierWave::MimeTypes

  process :set_content_type

  # Choose what kind of storage to use for this uploader:
  permissions = 0666
  directory_permissions = 0777
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{Rails.root}/public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def move_to_cache
    true
  end

  def move_to_store
    true
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:

  # version :web_thumb do
  #     # process :scale => [120, 120]
  #     # if processable?
  #     process :resize_to_fit => [200,200]
  #     process :convert => 'jpg'
  #     process :thumbnail_pdf
  #     def full_filename (for_file = model.file.file)
  #         super.chomp(File.extname(super)) + '.jpg'
  #     end
  # end

  # def processable? upload_name
  #     File.extname(upload_name.path) != ".mp3"
  # end

  # def extract()
  #   images = Magick::ImageList.new(current_path)
  #   images.write "out.jpg"
  # end

  # def extract #(format)
  #   cache_stored_file! if !cached?
  #   # Manually create upload dir as its not created at this point
  #   FileUtils.mkdir_p "#{Rails.root}/#{store_dir}"
  #   images = Magick::ImageList.new(current_path)
  #   images.write "#{Rails.root}/#{store_dir}/#{filename}"
  # end

  # def thumbnail_pdf
  #     manipulate! do |file|
  #         # file.format("png", 1)
  #         file.resize("150x150")
  #         file = yield(file) if block_given?
  #         file
  #     end
  #     # manipulate! do |img|
  #     #     img = img.sepiatone
  #     #     img = img.auto_orient
  #     #     img = img.radial_blur(blur_factor)
  #     # end
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(pdf rtf doc docx xls xlsx ppt pptx csv rtf txt)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
