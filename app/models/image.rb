class Image
  include Mongoid::Document

  field :caption, type: String
  field :location, type: String

  validates :location, presence: true

  mount_uploader :image, ImageUploader
end
