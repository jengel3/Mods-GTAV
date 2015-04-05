# == Schema Information
#
# Table name: downloads
#
#  id            :integer          not null, primary key
#  ip_address    :inet
#  submission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Download < ActiveRecord::Base
  before_create :add_download
  
  belongs_to :submission

  def add_download
    submission.download_count += 1
    submission.save
  end
end
