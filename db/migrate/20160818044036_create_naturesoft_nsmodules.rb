class CreateNaturesoftNsmodules < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_nsmodules do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
