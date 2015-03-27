class UploadSerializer < ActiveModel::Serializer
  attributes :id, :name, :changelog, :approved_at, :created_at

  has_one :submission

  def id
    object.id.to_s
  end
end
