class Image
  include Rails.application.routes.url_helpers
  include Mongoid::Document

  before_create :remove_old

  field :caption, type: String
  field :location, type: String, default: "Main"

  validates :location, presence: true, inclusion: { in: %w[Thumbnail Main] }
  mount_uploader :image, ImageUploader

  def remove_old
    if self.location == 'Main'
      submission.images.where(:location => "Main").destroy_all
    end
  end

  belongs_to :submission
  
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
