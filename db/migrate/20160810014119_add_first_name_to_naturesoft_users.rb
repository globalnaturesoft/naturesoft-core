class AddFirstNameToNaturesoftUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_users, :first_name, :string
  end
end
