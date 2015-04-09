# == Schema Information
#
# Table name: submissions
#
#  id             :integer          not null, primary key
#  name           :string
#  body           :text
#  baked_body     :text
#  approved_at    :time
#  category       :string
#  sub_category   :string
#  like_count     :integer          default(0)
#  dislike_count  :integer          default(0)
#  download_count :integer          default(0)
#  avg_rating     :integer          default(0)
#  last_favorited :time
#  creator_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string
#

FactoryGirl.define do
  factory :submission do
    name { Faker::App.name }
    body { Faker::Lorem.paragraph(3) }
    approved_at { DateTime.now }
    category { CATEGORIES.keys.sample.to_s }
    sub_category { CATEGORIES[sub_category.to_sym].sample.downcase.gsub(' ', '_') }
    last_favorited { nil }
    creator { create(:user) }
  end
end
