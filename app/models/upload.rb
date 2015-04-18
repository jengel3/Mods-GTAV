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

class Upload < ActiveRecord::Base
  belongs_to :submission
  after_create :set_updated

  validates :version, presence: true
  validates :upload, presence: true

  mount_uploader :upload, UploadUploader

  def display_text
    upload.filename + ' ' + self.size
  end

  def set_updated
    if submission.approved_at
      submission.last_updated = DateTime.now
      submission.save
    end
  end
end
