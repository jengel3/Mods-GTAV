class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :name, :body, :type

  has_one :creator
  def id
    object.id.to_s
  end
end
