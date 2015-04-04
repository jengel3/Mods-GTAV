# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  location      :string
#  submission_id :integer
#  image         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

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
