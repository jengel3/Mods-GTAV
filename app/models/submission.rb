class Submission
  include ApplicationHelper
  include Mongoid::Document
  include Mongoid::Timestamps
  include GlobalID::Identification
  include Mongoid::Slug

  before_save :bake_description

  field :name, type: String
  field :body, type: String
  field :baked_body, type: String
  field :download_count, type: Integer, default: 0
  field :approved_at, type: Time

  field :category
  field :sub_category

  field :like_count, type: Integer, default: 0
  field :dislike_count, type: Integer, default: 0
  field :download_count, type: Integer, default: 0
  field :avg_rating, type: Integer, default: 0

  alias_attribute :title, :name
  alias_attribute :description, :body

  slug :name, history: true

  belongs_to :creator, class_name: 'User', inverse_of: :submissions
  validates :name, uniqueness: true, presence: true
  
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy

  has_many :likes, :as => :likable, :dependent => :destroy
  has_many :dislikes, :as => :dislikable, :dependent => :destroy

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
