# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  text          :text
#  like_count    :integer
#  user_id       :integer
#  submission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#

FactoryGirl.define do
  factory :comment do
    text "MyText"
like_count 1
user_id 1
submission_id 1
  end

end
