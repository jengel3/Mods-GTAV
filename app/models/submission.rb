class Submission
  include ApplicationHelper
  include Mongoid::Document
  include Mongoid::Timestamps
  include GlobalID::Identification
  include Mongoid::Slug

  before_save :bake_description

  field :name, type: String
  field :body, type: String
  field :baked_body, type: String
  field :type, type: String
  field :download_count, type: Integer, default: 0
  field :approved_at, type: Time

  field :total_downloads, type: Integer, default: 0

  alias_attribute :title, :name
  alias_attribute :description, :body

  slug :name, history: true

  belongs_to :creator, class_name: 'User', inverse_of: :submissions
  validates :name, uniqueness: true, presence: true
  # validates :type, presence: true # Add inclusion
  
  has_many :comments
  has_many :images

  def bake_description
    self.baked_body = bake_markdown(self.body)
  end
end
