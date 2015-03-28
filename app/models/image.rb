class Image
  include Rails.application.routes.url_helpers
  include Mongoid::Document

  field :caption, type: String
  field :location, type: String

  # validates :location, presence: true

  mount_uploader :image, ImageUploader

  belongs_to :submission

  def num
    location[ -1..-1 ].to_i
  end

  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => image_path(:id => id),
      "delete_type" => "DELETE" 
    }
  end
end
