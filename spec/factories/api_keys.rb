# == Schema Information
#
# Table name: api_keys
#
#  id      :integer          not null, primary key
#  key     :string
#  version :string
#  user_id :string
#

FactoryGirl.define do
  factory :api_key do
    key "MyString"
version "MyString"
user_id "MyString"
  end

end
