class AddLastUpdatedToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :last_updated, :datetime
  end
end
