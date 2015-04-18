class AddVidthumbToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :vidthumb, :string
  end
end
