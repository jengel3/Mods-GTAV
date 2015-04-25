class AddLangToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lang, :string, :default => "en", null: false
  end
end
