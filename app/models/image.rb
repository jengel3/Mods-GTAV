class Image
  include Rails.application.routes.url_helpers
  include Mongoid::Document

  before_create :remove_old

  field :location, type: String, default: "Main"

  validates :location, presence: true, inclusion: { in: %w[Thumbnail Main] }
  
  mount_uploader :image, ImageUploader

  index({ submission_id: 1 }, { unique: true, name: "image_sub_index" })

  belongs_to :submission
  
  def remove_old
    if self.location == 'Main'
      submission.images.where(:location => "Main").destroy_all
    end
  end
end
