# == Schema Information
#
# Table name: dislikes
#
#  id              :integer          not null, primary key
#  dislikable_type :string
#  dislikable_id   :integer
#  user_id         :integer
#  created_at      :datetime         not null
#

FactoryGirl.define do
  factory :dislike do
  end
end
