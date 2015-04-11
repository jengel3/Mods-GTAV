# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  url        :string
#  thumb      :string
#  user_id    :integer
#  youtube_id :string
#  created_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Video, type: :model do
end
