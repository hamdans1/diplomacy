class AddGroupToCampaign < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :group_id, :integer
    add_index :campaigns, :group_id
  end
end
