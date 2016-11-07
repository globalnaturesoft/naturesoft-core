class AddEmailConfirmColumnToNaturesoftUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_users, :email_confirmed, :boolean, :default => false
    add_column :naturesoft_users, :confirm_token, :string
  end
end
