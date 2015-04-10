class AddYoutubeIdToVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :name
    add_column :videos, :youtube_id, :string
    change_column :videos, :created_at, :datetime, null: false
  end
end
