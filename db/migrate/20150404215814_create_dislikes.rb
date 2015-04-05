class CreateDislikes < ActiveRecord::Migration
  def change
    create_table :dislikes do |t|
      t.string :dislikable_type
      t.integer :dislikable_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
