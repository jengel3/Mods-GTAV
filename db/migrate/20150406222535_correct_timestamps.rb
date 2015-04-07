class CorrectTimestamps < ActiveRecord::Migration
  def change
    add_column :likes, :created_at, :datetime
    
    remove_column :dislikes, :updated_at
    remove_column :downloads, :updated_at
    remove_column :images, :updated_at
    remove_column :uploads, :updated_at
    remove_column :users, :updated_at
  end
end
