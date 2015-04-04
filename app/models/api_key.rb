class ApiKey < ActiveRecord::Base
  before_create :generate_token

  def generate_token
    begin
      self.key = SecureRandom.hex
    end while ApiKey.where(key: key).first
  end

  belongs_to :user
end
