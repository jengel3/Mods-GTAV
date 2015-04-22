# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  process resize_to_fill: [70, 70]


  def extension_white_list
    %w(jpg jpeg png)
  end

  def filename
    "avatar.png" if original_filename
  end

end
