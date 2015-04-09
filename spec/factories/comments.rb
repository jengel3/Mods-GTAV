# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  text          :text
#  like_count    :integer          default(0)
#  user_id       :integer
#  submission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#
require 'faker'
FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.paragraph }
    user { create(:user) }
    submission { create(:submission) }
  end
end
