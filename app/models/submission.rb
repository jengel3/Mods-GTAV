class Submission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :body, type: String
  field :type, type: String
  field :download_count, type: Integer, default: 0
  field :approved_at, type: Time

  belongs_to :creator, class_name: 'User', inverse_of: :submissions
  has_many :comments
end
