class ChangeToDatetimeOnSubmissions < ActiveRecord::Migration
  def change
    remove_column :submissions, :last_favorited
    remove_column :submissions, :approved_at
    remove_column :uploads, :approved_at

    add_column :submissions, :last_favorited, :datetime
    add_column :submissions, :approved_at, :datetime
    add_column :uploads, :approved_at, :datetime
  end
end
