class AddImageToNaturesoftUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_users, :image, :string
  end
end
