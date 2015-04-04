class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :name
      t.text :body
      t.text :baked_body
      t.time :approved_at
      t.string :category
      t.string :sub_category
      t.integer :like_count
      t.integer :dislike_count
      t.integer :download_count
      t.integer :avg_rating
      t.time :last_favorited
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
