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

require 'rails_helper'

RSpec.describe Submission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
