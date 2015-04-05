class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :likable_type
      t.string :user_id
      t.integer :likable_id
    end
  end
end
