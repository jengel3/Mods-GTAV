class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :key
      t.string :version
      t.string :user_id

      t.timestamps null: false
    end
  end
end
