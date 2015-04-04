# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  location      :string
#  submission_id :integer
#  image         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :image do
    location "MyString"
submission_id 1
image "MyString"
  end

end
