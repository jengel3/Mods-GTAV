class AddEmailSettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_approval, :boolean
    add_column :users, :email_reports, :boolean
    add_column :users, :email_comments, :boolean
    add_column :users, :email_news, :boolean
  end
end
