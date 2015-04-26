# encoding: utf-8
class UploadUploader < CarrierWave::Uploader::Base

  storage :file

  process :save_file_size

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(zip tar rar)
  end

  def save_file_size
    if self.size
      size = self.size / 1000000
      unit = "mb"
      if size < 1
        size = self.size / 1000
        unit = "kb"
      end
      model.size = size.to_s + unit
    else
      model.size = "0kb"
    end
  end
end
