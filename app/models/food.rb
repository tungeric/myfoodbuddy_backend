# == Schema Information
#
# Table name: foods
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  amount_g   :integer          default(1), not null
#  calories   :integer          default(0)
#  protein    :integer          default(0)
#  carbs      :integer          default(0)
#  fat        :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :string
#

class Food < ApplicationRecord
  validates :name, :amount_g, presence: true

  has_many :meal_foods, dependent: :destroy
  has_many :meals, through: :meal_foods

  def averageness_index
    calories_diff = (self.calories - Meal.average_calories_per_food).to_f / Meal.average_calories_per_food
    protein_diff = (self.protein - Meal.average_protein_per_food).to_f / Meal.average_protein_per_food
    carbs_diff = (self.carbs - Meal.average_carbs_per_food).to_f / Meal.average_carbs_per_food
    fat_diff = (self.fat - Meal.average_fat_per_food).to_f / Meal.average_fat_per_food
    total_diff = (calories_diff + protein_diff + carbs_diff + fat_diff)
    averageness = 1 - (total_diff.to_f / 4)
    averageness
    # (self.calories / Meal.average_calories_per_food + 
    # self.protein / Meal.average_protein_per_food + 
    # self.carbs / Meal.average_carbs_per_food + 
    # self.fat / Meal.average_fat_per_food).to_f / 4
  end
end
