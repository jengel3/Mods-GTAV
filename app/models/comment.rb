class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :text, type: String

  belongs_to :user
  belongs_to :submission
end
