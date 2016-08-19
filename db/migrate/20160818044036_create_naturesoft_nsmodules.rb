class CreateNaturesoftNsmodules < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_nsmodules do |t|
      t.string :name
      t.string :module
      t.text :options
      t.references :user, references: :naturesoft_users

      t.timestamps
    end
  end
end
