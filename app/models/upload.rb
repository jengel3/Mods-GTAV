# == Schema Information
#
# Table name: uploads
#
#  id            :integer          not null, primary key
#  name          :string
#  changelog     :text
#  approved_at   :time
#  size          :string
#  submission_id :integer
#  upload        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Upload < ActiveRecord::Base
  belongs_to :submission

  validates :name, presence: true

  mount_uploader :upload, UploadUploader

  def display_text
    upload.filename + ' ' + self.size
  end
end
