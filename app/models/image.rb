class Image < ActiveRecord::Base
  before_create :remove_old

  validates :location, presence: true, inclusion: { in: %w[Thumbnail Main] }
  
  mount_uploader :image, ImageUploader

  belongs_to :submission
  
  def remove_old
    if self.location == 'Main'
      submission.images.where(:location => "Main").destroy_all
    end
  end
end
