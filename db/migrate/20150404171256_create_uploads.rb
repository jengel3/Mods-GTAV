class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :name
      t.text :changelog
      t.time :approved_at
      t.string :size
      t.integer :submission_id
      t.string :upload

      t.timestamps null: false
    end
  end
end
