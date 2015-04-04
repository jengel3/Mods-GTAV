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

class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :name, :body, :category, :sub_category, :like_count, :dislike_count, :download_count

  has_one :creator
  has_many :comments
  def id
    object.id.to_s
  end
end
