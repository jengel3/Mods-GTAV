# == Schema Information
#
# Table name: likes
#
#  id           :integer          not null, primary key
#  likable_type :string
#  user_id      :string
#  likable_id   :integer
#

FactoryGirl.define do
  factory :like do
    likable_type "MyString"
user_id "MyString"
likable_id 1
  end

end
