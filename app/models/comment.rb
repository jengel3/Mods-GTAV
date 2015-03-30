class Comment
  include Mongoid::Document
  include Mongoid::Paranoia
  include GlobalID::Identification
  include Mongoid::Timestamps::Created

  field :text, type: String

  validates :text, presence: true

  belongs_to :user
  belongs_to :submission
  
  # has_many :likes, :as => :likable, :dependent => :destroy
end
