class ResetCreatedAtOnVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :created_at
    add_column :videos, :created_at, :datetime, null: false
  end
end
