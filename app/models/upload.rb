class Upload
  include Mongoid::Document
  include GlobalID::Identification
  include Mongoid::Timestamps::Created

  field :name, type: String, default: ""
  field :changelog, type: String, default: ""
  field :approved_at, type: Time, default: nil
  field :size, type: String

  belongs_to :submission

  validates :name, presence: true

  mount_uploader :upload, UploadUploader

  def display_text
    upload.filename + ' ' + self.size
  end
end
