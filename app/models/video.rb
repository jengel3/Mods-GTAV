# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  url        :string
#  thumb      :string
#  user_id    :integer
#  created_at :datetime         default(Fri, 10 Apr 2015 20:59:09 UTC +00:00), not null
#  youtube_id :string
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
    thumb_uri = "http://img.youtube.com/vi/#{self.youtube_id}/0.jpg"
    self.thumb = thumb_uri 
  end
end
