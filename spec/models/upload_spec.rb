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

require 'rails_helper'

RSpec.describe Upload, type: :model do
end
