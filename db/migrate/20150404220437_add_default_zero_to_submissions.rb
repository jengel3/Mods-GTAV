class AddDefaultZeroToSubmissions < ActiveRecord::Migration
  def change
    change_column :submissions, :like_count, :integer, :default => 0
    change_column :submissions, :dislike_count, :integer, :default => 0
    change_column :submissions, :avg_rating, :integer, :default => 0
    change_column :submissions, :download_count, :integer, :default => 0
  end
end
