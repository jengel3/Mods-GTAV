class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :name, :body, :type

  has_one :creator
  has_many :comments
  def id
    object.id.to_s
  end
end