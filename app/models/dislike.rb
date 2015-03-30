class Dislike
  include Mongoid::Document
  belongs_to :dislikable, polymorphic: true
  belongs_to :user
end
