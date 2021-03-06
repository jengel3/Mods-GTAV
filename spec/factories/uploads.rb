# == Schema Information
#
# Table name: uploads
#
#  id            :integer          not null, primary key
#  changelog     :text
#  size          :string
#  submission_id :integer
#  upload        :string
#  created_at    :datetime         not null
#  version       :string
#  approved_at   :datetime
#

require 'faker'
FactoryGirl.define do
  factory :upload do
    submission { create(:submission) }
    verison { Faker::App.version }
    changelog { Faker::Lorem.paragraph }
    approved_at { DateTime.now }
    upload { File.open(File.join(Rails.root, 'spec', 'data', 'data.zip')) }
  end
end
