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

require 'rails_helper'

RSpec.describe Upload, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
