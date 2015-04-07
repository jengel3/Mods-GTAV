# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  location      :string
#  submission_id :integer
#  image         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ImageSerializer < ActiveModel::Serializer
  attributes :id, :location

  has_one :submission

end
