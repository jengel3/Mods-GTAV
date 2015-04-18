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
  mount_uploader :vidthumb, VidthumbUploader
  belongs_to :user

  validates :url, presence: true
  validates :youtube_id, presence: true
  validates :thumb, presence: true

  def self.youtube_id(url)
    return url.split("v=")[1][0..11]
  end

  def self.thumb_url(id)
    return false if !id
    thumb_uri = "https://img.youtube.com/vi/#{id}/mqdefault.jpg"
    return thumb_uri 
  end
end
