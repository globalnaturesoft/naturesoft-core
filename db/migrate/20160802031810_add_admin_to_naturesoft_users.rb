class AddAdminToNaturesoftUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_users, :admin, :boolean, default: false
  end
end
