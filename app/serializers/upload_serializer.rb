# == Schema Information
#
# Table name: uploads
#
#  id            :integer          not null, primary key
#  changelog     :text
#  size          :string
#  submission_id :integer
#  upload        :string
#  created_at    :datetime         not null
#  version       :string
#  approved_at   :datetime
#

class UploadSerializer < ActiveModel::Serializer
  attributes :id, :version, :changelog, :approved_at, :created_at

  has_one :submission
end
