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
#  like_count     :integer
#  dislike_count  :integer
#  download_count :integer
#  avg_rating     :integer
#  last_favorited :time
#  creator_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string
#

FactoryGirl.define do
  factory :submission do
    name "MyString"
body "MyText"
baked_body "MyText"
approved_at "2015-04-04 12:11:14"
category "MyString"
sub_category "MyString"
like_count 1
dislike_count 1
download_count 1
avg_rating 1
last_favorited "2015-04-04 12:11:14"
creator_id 1
  end

end
