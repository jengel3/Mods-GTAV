class ImageSerializer < ActiveModel::Serializer
  attributes :id, :location

  has_one :submission

  def id
    object.id.to_s
  end
end
