class AddIndexToUploads < ActiveRecord::Migration
  def change
    add_index :uploads, :submission_id
  end
end
