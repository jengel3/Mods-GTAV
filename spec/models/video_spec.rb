# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  url        :string
#  thumb      :string
#  user_id    :integer
#  created_at :datetime         default(Fri, 10 Apr 2015 20:59:09 UTC +00:00), not null
#  youtube_id :string
#

require 'rails_helper'

RSpec.describe Video, type: :model do
end
