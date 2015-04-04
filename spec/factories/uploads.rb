# == Schema Information
#
# Table name: uploads
#
#  id            :integer          not null, primary key
#  name          :string
#  changelog     :text
#  approved_at   :time
#  size          :string
#  submission_id :integer
#  upload        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :upload do
    name "MyString"
changelog "MyText"
approved_at "2015-04-04 12:12:56"
size "MyString"
submission_id 1
  end

end
