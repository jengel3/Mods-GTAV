class AddIndexToImages < ActiveRecord::Migration
  def change
    add_index :images, :submission_id
  end
end
