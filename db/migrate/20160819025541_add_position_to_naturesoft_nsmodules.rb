class AddPositionToNaturesoftNsmodules < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_nsmodules, :position, :string
  end
end
