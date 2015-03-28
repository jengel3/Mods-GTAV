# encoding: utf-8
class UploadUploader < CarrierWave::Uploader::Base

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(zip tar rar)
  end
end