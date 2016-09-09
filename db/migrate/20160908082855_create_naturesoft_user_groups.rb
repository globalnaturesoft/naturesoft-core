class CreateNaturesoftUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_user_groups do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
