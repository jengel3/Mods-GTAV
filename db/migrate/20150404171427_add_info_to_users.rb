class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :admin, :boolean
    add_column :users, :biography, :text
    add_column :users, :avatar, :string
  end
end
