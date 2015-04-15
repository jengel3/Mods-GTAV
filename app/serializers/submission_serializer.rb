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

class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :name, :body, :category, :sub_category, :like_count, :dislike_count, :avg_rating, :download_count

  has_one :creator
  has_many :comments
  has_many :uploads
  
end
