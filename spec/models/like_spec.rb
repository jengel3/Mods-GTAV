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

require 'rails_helper'

RSpec.describe Like, type: :model do
end
