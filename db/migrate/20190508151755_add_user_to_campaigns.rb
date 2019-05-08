class AddUserToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :user_id, :integer
    add_index :campaigns, :user_id
  end
end
