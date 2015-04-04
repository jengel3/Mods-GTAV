class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.inet :ip_address
      t.integer :submission_id

      t.timestamps null: false
    end
  end
end
