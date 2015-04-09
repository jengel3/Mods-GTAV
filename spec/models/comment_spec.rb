# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  text          :text
#  like_count    :integer          default(0)
#  user_id       :integer
#  submission_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
end
