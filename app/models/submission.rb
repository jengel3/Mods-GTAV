# == Schema Information
#
# Table name: submissions
#
#  id             :integer          not null, primary key
#  name           :string
#  body           :text
#  baked_body     :text
#  approved_at    :time
#  category       :string
#  sub_category   :string
#  like_count     :integer
#  dislike_count  :integer
#  download_count :integer
#  avg_rating     :integer
#  last_favorited :time
#  creator_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string
#

class Submission < ActiveRecord::Base
  include ApplicationHelper
  extend FriendlyId

  before_save :bake_description

  validates :name, uniqueness: true, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :sub_category, presence: true

  belongs_to :creator, class_name: 'User', inverse_of: :submissions
  
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :uploads, :dependent => :destroy

  # has_many :likes, :as => :likable, :dependent => :destroy
  # has_many :dislikes, :as => :dislikable, :dependent => :destroy

  friendly_id :name, use: [:slugged, :finders]


  class << self
    def for_category(category)
      where(:category => category)
    end

    def for_subcategory(subcategory)
      where(:sub_category => subcategory)
    end

    def favorited(count = 3)
      where(:last_favorited.exists => true).desc(:last_favorited).limit(count)
    end
  end

  def fetch_creator(force = false)
    key = "SUBMISSION:CREATOR:#{id}"
    result = REDIS.get(key)
    if !result || force
      result = creator.username
      REDIS.set(key, result)
      REDIS.expire(key, 24.hours)
    end
    return result
  end

  def fetch_display(force = false)
    key = "SUBMISSION:DISPLAY:#{id}"
    result = REDIS.get(key)
    if !result || force
      result = main_image.to_json
      REDIS.set(key, result)
      REDIS.expire(key, 24.hours)
    end
    return JSON.load(result)
  end

  def to_s
    name
  end

  def update_rating
    if dislike_count > like_count
      self.avg_rating = (dislike_count - like_count) * -1
    elsif like_count > dislike_count
      self.avg_rating = like_count - dislike_count
    else
      self.avg_rating = 0
    end
    self.save
  end

  def bake_description
    self.baked_body = bake_markdown(self.body)
  end

  def main_image
    images.where(:location => "Main").first
  end

  def thumbnails
    images.where(:location => "Thumbnail")
  end

  def latest
    uploads.desc(:created_at).first
  end

  def can_manage(user = nil)
    if user
      user.admin || creator == user
    end
  end

  def has_liked(user = nil)
    if user
      return likes.where(:user => user).exists?
    end
    return false
  end

  def has_disliked(user = nil)
    if user
      return dislikes.where(:user => user).exists?
    end
    return false
  end
end
