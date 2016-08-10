class AddLastNameToNaturesoftUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_users, :last_name, :string
  end
end
