class AddDefaultsToEmailSettings < ActiveRecord::Migration
  def change
    change_column :users, :email_approval, :boolean, :default => true
    change_column :users, :email_reports, :boolean, :default => true
    change_column :users, :email_comments, :boolean, :default => true
    change_column :users, :email_news, :boolean, :default => true
  end
end
