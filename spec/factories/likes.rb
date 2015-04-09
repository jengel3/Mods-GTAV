# == Schema Information
#
# Table name: likes
#
#  id           :integer          not null, primary key
#  likable_type :string
#  user_id      :string
#  likable_id   :integer
#  created_at   :datetime
#

FactoryGirl.define do
  factory :like do
    
  end
end
