class ApiKey
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  has_secure_token :key

  belongs_to :user
end
