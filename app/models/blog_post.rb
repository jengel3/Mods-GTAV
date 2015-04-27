# == Schema Information
#
# Table name: blog_posts
#
#  id         :integer          not null, primary key
#  author_id  :integer
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BlogPost < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  validates :body, presence: true
  validates :author_id, presence: true
  validates :title, presence: true
end
