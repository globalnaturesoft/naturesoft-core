class AddUserGroupIdToNaturesoftUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_users, :user_group_id, :integer
  end
end
