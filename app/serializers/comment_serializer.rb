class CommentSerializer < ActiveModel::Serializer
  attributes :id, :submission_id, :text, :created_at, :milliseconds

  has_one :user

  def id
    object.id.to_s
  end

  def milliseconds
    object.created_at.to_i
  end

  def submission_id
    object.submission_id.to_s
  end
end
