# == Schema Information
#
# Table name: downloads
#
#  id            :integer          not null, primary key
#  ip_address    :inet
#  submission_id :integer
#  created_at    :datetime         not null
#
require 'faker'
FactoryGirl.define do
  factory :download do
    submission { create(:submission) }
    ip_address { Faker::Internet.ip_v4_address }
  end
end
