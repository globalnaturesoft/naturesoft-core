class CreateNaturesoftOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_options do |t|
      t.string :category
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
