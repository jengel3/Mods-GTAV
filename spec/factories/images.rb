# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  location      :string
#  submission_id :integer
#  image         :string
#  created_at    :datetime         not null
#

FactoryGirl.define do
  factory :image do
    submission { create(:submission) }
    location { "Main" }
    image { File.open(File.join(Rails.root, 'spec', 'data', 'thumbnail1.jpg')) }
  end
end
