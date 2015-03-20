class SubmissionSerializer < ActiveModel::Serializer
  attributes :text, :created_at

  has_one :user
  def id
    object.id.to_s
  end
end
