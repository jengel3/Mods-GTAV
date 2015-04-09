# == Schema Information
#
# Table name: dislikes
#
#  id              :integer          not null, primary key
#  dislikable_type :string
#  dislikable_id   :integer
#  user_id         :integer
#  created_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Dislike, type: :model do
end
