# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  #include Sprockets::Helpers::RailsHelper
  #include Sprockets::Helpers::IsolatedHelper

  include Cloudinary::CarrierWave

  process :tags => ["photo_album_sample"]
  process :convert => "png"

  version :thumbnail do
    eager
    #resize_to_fit(60, 60)
    cloudinary_transformation :width=>60, :height=>60, :crop => :thumb, :gravity => :face, :radius => :max          
  end  

  version :micro do
    eager
    #resize_to_fit(60, 60)
    cloudinary_transformation :width=>40, :height=>40, :crop => :thumb, :gravity => :face, :radius => :max          
  end  

  version :post_image do
    eager
    #resize_to_fit(60, 60)
    cloudinary_transformation :width => 200, :height => 300, :crop => :limit     
  end  

  version :comment do
    eager
    #resize_to_fit(60, 60)
    cloudinary_transformation :width => 20, :height => 20, :crop => :thumb, :gravity => :face, :radius => :max   
  end  
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  #def store_dir
  #  "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
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
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
