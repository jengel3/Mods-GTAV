# == Schema Information
#
# Table name: likes
#
#  id           :integer          not null, primary key
#  likable_type :string
#  user_id      :string
#  likable_id   :integer
#  created_at   :datetime
#

class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
  belongs_to :user
end
