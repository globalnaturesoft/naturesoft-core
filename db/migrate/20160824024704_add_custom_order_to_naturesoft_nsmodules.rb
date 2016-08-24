class AddCustomOrderToNaturesoftNsmodules < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_nsmodules, :custom_order, :integer, default: 0
  end
end
