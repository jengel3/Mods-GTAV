# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  url        :string
#  thumb      :string
#  user_id    :integer
#  youtube_id :string
#  created_at :datetime         not null
#

class Video < ActiveRecord::Base
  belongs_to :user

  before_validation :set_youtube_id
  before_validation :set_thumbnail

  validates :url, presence: true
  validates :youtube_id, presence: true
  validates :thumb, presence: true

  def set_youtube_id
    self.youtube_id = self.url.split("v=")[1][0..11]
  end

  def set_thumbnail
    return false if !self.youtube_id
    thumb_uri = "https://img.youtube.com/vi/#{self.youtube_id}/mqdefault.jpg"
    self.thumb = thumb_uri 
  end
end
