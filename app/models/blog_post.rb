class BlogPost
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, type: String
  field :body, type: String
  field :tags, type: Array

  belongs_to :author, class_name: 'User'
end
