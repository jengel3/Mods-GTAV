# == Schema Information
#
# Table name: uploads
#
#  id            :integer          not null, primary key
#  changelog     :text
#  approved_at   :time
#  size          :string
#  submission_id :integer
#  upload        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  version       :string
#

class UploadSerializer < ActiveModel::Serializer
  attributes :id, :name, :changelog, :approved_at, :created_at

  has_one :submission


end
