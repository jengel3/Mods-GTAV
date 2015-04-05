# == Schema Information
#
# Table name: dislikes
#
#  id              :integer          not null, primary key
#  dislikable_type :string
#  dislikable_id   :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Dislike < ActiveRecord::Base
  belongs_to :dislikable, polymorphic: true
  belongs_to :user
end
