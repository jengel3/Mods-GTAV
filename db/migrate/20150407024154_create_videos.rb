class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.string :name
      t.string :thumb
      t.integer :user_id

      t.datetime :created_at, default: DateTime.now
    end
  end
end
