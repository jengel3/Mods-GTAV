# == Schema Information
#
# Table name: submissions
#
#  id             :integer          not null, primary key
#  name           :string
#  body           :text
#  baked_body     :text
#  category       :string
#  sub_category   :string
#  like_count     :integer          default(0)
#  dislike_count  :integer          default(0)
#  download_count :integer          default(0)
#  avg_rating     :integer          default(0)
#  creator_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string
#  last_favorited :datetime
#  approved_at    :datetime
#

require 'faker'
FactoryGirl.define do
  factory :submission do
    name { Faker::App.name }
    body { Faker::Lorem.paragraph(3) }
    approved_at { DateTime.now }
    category { CATEGORIES.keys.sample.to_s }
    sub_category { CATEGORIES[category.to_sym].sample.downcase.gsub(' ', '_') }
    creator { create(:user) }
  end
end
