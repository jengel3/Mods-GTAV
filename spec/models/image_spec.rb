# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  location      :string
#  submission_id :integer
#  image         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Image, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
