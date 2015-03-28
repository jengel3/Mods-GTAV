class Image
  include Rails.application.routes.url_helpers
  include Mongoid::Document

  before_create :remove_old, :if => :is_main?

  field :caption, type: String
  field :location, type: String, default: "Main"

  validates :location, presence: true, inclusion: { in: %w[Thumbnail Main] }
  mount_uploader :image, ImageUploader

  def remove_old
    submission.images.where(:location => "Main")
  end

  def is_main?
    location == 'Main'
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
