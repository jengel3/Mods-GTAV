class AddDefaultZeroToComments < ActiveRecord::Migration
  def change
    change_column :comments, :like_count, :integer, :default => 0
  end
end
