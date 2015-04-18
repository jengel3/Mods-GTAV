# encoding: utf-8

class VidthumbUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  process resize_to_fit: [130, 100]


  def extension_white_list
    %w(jpg jpeg png)
  end

  def filename
    "thumb.png" if original_filename
  end

end
