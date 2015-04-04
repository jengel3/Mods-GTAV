# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  text          :text
#  like_count    :integer
#  user_id       :integer
#  submission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#

class Comment < ActiveRecord::Base
  acts_as_paranoid
  
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
