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

FactoryGirl.define do
  factory :download do
    ip_address ""
submission_id 1
  end

end
