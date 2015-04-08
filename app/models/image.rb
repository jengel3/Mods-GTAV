# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  location      :string
#  submission_id :integer
#  image         :string
#  created_at    :datetime         not null
#

class Image < ActiveRecord::Base
  before_create :remove_old
  after_create :create_versions

  validates :location, presence: true, inclusion: { in: %w[Thumbnail Main] }
  
  mount_uploader :image, ImageUploader

  belongs_to :submission

  def create_versions
    image.recreate_versions!
  end
  
  def remove_old
    REDIS.del("SUBMISSION:DISPLAY:#{submission.id}")
    if self.location == 'Main'
      submission.images.where(:location => "Main").destroy_all
    end
  end
end
