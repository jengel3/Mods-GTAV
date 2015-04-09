# == Schema Information
#
# Table name: api_keys
#
#  id      :integer          not null, primary key
#  key     :string
#  version :string
#  user_id :string
#
require 'faker'
FactoryGirl.define do
  factory :api_key do
    key { Faker::Lorem.characters(25) }
    version { "V1" }
    user { create(:user) }
  end
end
