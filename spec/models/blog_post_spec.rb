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

require 'rails_helper'

RSpec.describe BlogPost, type: :model do
end
