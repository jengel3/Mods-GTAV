class ApiKey
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  before_create :generate_token

  def generate_token
    begin
      self.key = SecureRandom.hex
    end while ApiKey.where(key: key).first
  end

  field :key, type: String
  field :version, type: String

  belongs_to :user
end
