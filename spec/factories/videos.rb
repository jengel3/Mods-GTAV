# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  url        :string
#  thumb      :string
#  user_id    :integer
#  youtube_id :string
#  created_at :datetime         not null
#

require 'faker'
FactoryGirl.define do
  factory :video do
  end
end
