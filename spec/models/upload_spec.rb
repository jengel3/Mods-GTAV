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
#  version       :string
#

require 'rails_helper'

RSpec.describe Upload, type: :model do
end
