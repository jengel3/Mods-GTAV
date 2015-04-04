class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.integer :author_id
      t.text :body
      t.string :title

      t.timestamps null: false
    end
  end
end
