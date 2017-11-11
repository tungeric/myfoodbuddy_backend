class CreateMealFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :meal_foods do |t|
      t.references :food, foreign_key: true
      t.references :meal, foreign_key: true

      t.timestamps
    end
  end
end
