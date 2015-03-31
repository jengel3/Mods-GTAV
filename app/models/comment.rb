class Comment
  include Mongoid::Document
  include Mongoid::Paranoia
  include GlobalID::Identification
  include Mongoid::Timestamps::Created

  field :text, type: String
  field :like_count, type: Integer, default: 0

  validates :text, presence: true

  belongs_to :user
  belongs_to :submission
  
  has_many :likes, :as => :likable, :dependent => :destroy

  def has_liked(user = nil)
    if user
      return likes.where(:user => user).exists?
    end
    return false

  end
end
