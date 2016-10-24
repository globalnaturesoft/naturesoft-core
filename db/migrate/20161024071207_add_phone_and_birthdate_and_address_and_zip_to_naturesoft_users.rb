class AddPhoneAndBirthdateAndAddressAndZipToNaturesoftUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_users, :phone, :string
    add_column :naturesoft_users, :birthdate, :datetime
    add_column :naturesoft_users, :address, :text
    add_column :naturesoft_users, :zip, :string
  end
end
