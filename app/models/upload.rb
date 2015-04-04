class Upload < ActiveRecord::Base
  belongs_to :submission

  validates :name, presence: true

  mount_uploader :upload, UploadUploader

  def display_text
    upload.filename + ' ' + self.size
  end
end
