class Submission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :body, type: String
  field :type, type: String
  field :download_count, type: Integer, default: 0
  field :approved_at, type: Time

  alias_attribute :title, :name
  alias_attribute :description, :body

  belongs_to :creator, class_name: 'User', inverse_of: :submissions
  validates :name, uniqueness: true, presence: true
  validates :type, presence: true # Add inclusion
  
  has_many :comments
end
