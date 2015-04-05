class RemoveNameFromUploads < ActiveRecord::Migration
  def change
    remove_column :uploads, :name
  end
end
