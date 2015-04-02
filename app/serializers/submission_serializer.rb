class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :name, :body, :category, :sub_category, :like_count, :dislike_count, :download_count

  has_one :creator
  has_many :comments
  def id
    object.id.to_s
  end
end
