class ImageSerializer < ActiveModel::Serializer
  attributes :id, :caption, :location

  has_one :submission

  def id
    object.id.to_s
  end
end
