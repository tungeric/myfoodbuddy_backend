class AddServingSizeToMealFood < ActiveRecord::Migration[5.1]
  def change
    add_column :meal_foods, :num_servings, :integer
  end
end
