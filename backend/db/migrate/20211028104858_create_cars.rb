class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :name
      t.index :name
      t.integer :mileage
      t.references :brand, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
