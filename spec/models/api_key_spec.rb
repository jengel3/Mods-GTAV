# == Schema Information
#
# Table name: api_keys
#
#  id      :integer          not null, primary key
#  key     :string
#  version :string
#  user_id :string
#

require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
