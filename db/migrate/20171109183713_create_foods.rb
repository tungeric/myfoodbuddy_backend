class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.integer :amount_g, null: false, default: 1
      t.integer :calories, default: 0
      t.integer :protein, default: 0
      t.integer :carbs, default: 0
      t.integer :fat, default: 0

      t.timestamps
    end
  end
end
