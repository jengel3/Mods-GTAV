# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  text          :text
#  like_count    :integer          default(0)
#  user_id       :integer
#  submission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :submission_id, :text, :created_at, :like_count

  has_one :user

  def id
    object.id.to_s
  end

  def submission_id
    object.submission_id.to_s
  end
end
