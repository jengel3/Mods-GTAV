# == Schema Information
#
# Table name: downloads
#
#  id            :integer          not null, primary key
#  ip_address    :inet
#  submission_id :integer
#  created_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Download, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
