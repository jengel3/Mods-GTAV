class AddIndicesToUsers < ActiveRecord::Migration
  def change
    add_index :users, :username, unique: true
    add_index :users, [:uid, :provider]
  end
end
