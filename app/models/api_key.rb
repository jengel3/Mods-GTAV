# == Schema Information
#
# Table name: api_keys
#
#  id      :integer          not null, primary key
#  key     :string
#  version :string
#  user_id :string
#

class ApiKey < ActiveRecord::Base
  before_create :generate_token

  def generate_token
    begin
      self.key = SecureRandom.hex
    end while ApiKey.where(key: key).first
  end

  belongs_to :user
end
