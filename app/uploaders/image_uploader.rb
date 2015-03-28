# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :preview, if: :is_main?
  version :thumb

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :preview do
    process :resize_to_fit => [232, 132]
  end

  version :thumb do
    process :resize_to_fit => [130, 74]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  private
  def is_main? picture
    model.location == 'Main'
  end

  def is_thumb? picture
    model.location == 'Thumbnail'
  end
end
