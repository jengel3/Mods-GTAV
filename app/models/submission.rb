# == Schema Information
#
# Table name: submissions
#
#  id             :integer          not null, primary key
#  name           :string
#  body           :text
#  baked_body     :text
#  category       :string
#  sub_category   :string
#  like_count     :integer          default(0)
#  dislike_count  :integer          default(0)
#  download_count :integer          default(0)
#  avg_rating     :integer          default(0)
#  creator_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string
#  last_favorited :datetime
#  approved_at    :datetime
#

require 'elasticsearch/model'
class Submission < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Rails.application.routes.url_helpers
  include SubmissionsHelper
  extend FriendlyId
  scope :approved, -> { where('submissions.approved_at IS NOT NULL') }
  
  before_save :bake_body
  before_save :delete_sub

  validates :name, uniqueness: true, presence: true
  validates :body, presence: true
  validate :categories

  belongs_to :creator, class_name: 'User', inverse_of: :submissions
  
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :uploads, :dependent => :destroy
  has_many :downloads, :dependent => :destroy

  has_many :likes, :as => :likable, :dependent => :destroy
  has_many :dislikes, :as => :dislikable, :dependent => :destroy

  friendly_id :name, use: [:slugged, :finders]

  class << self
    def for_category(category)
      where(:category => category)
    end

    def for_subcategory(subcategory)
      where(:sub_category => subcategory)
    end
  end

  def delete_sub
    self.sub_category = nil if category == "misc"
  end

  def categories
    if category && category != "misc"
      if CATEGORIES[category.to_sym]
        subs = CATEGORIES[category.to_sym]
        if !sub_category
          return errors.add(:sub_category, :is_missing)
        end
        sub = sub_category.gsub('_', ' ').titleize
        errors.add(:sub_category, :is_invalid) unless subs.include?(sub)
      else
        errors.add(:category, :is_invalid)
      end
    elsif !category
      errors.add(:category, :is_missing)
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
      main = main_image
      return nil if !main
      result = main.to_json
      REDIS.set(key, result)
      REDIS.expire(key, 24.hours)
    end
    return JSON.load(result)
  end

  def to_s
    name
  end

  def path
    submission_path(self)
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

  def bake_body
    self.baked_body = bake_markdown(self.body)
  end

  def main_image
    images.where(:location => "Main").first
  end

  def thumbnails
    images.where(:location => "Thumbnail")
  end

  def latest
    return nil if approved_at.nil?
    uploads.order('created_at DESC').first
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

  def favorite
    self.last_favorited = DateTime.now
    self.save
    REDIS.del('STAT:FAVORITES')
  end
end
