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
end
