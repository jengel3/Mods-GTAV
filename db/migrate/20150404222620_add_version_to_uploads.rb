class AddVersionToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :version, :string
  end
end
