class Like
  include Mongoid::Document
  belongs_to :likable, polymorphic: true
  belongs_to :user
end
