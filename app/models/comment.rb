class Comment < ActiveRecord::Base

  validates :text, presence: true

  belongs_to :user
  belongs_to :submission
  
  # has_many :likes, :as => :likable, :dependent => :destroy

  def has_liked(user = nil)
    if user
      return likes.where(:user => user).exists?
    end
    return false
  end
end
