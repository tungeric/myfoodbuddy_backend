# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  name       :string
#  meal_time  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Meal < ApplicationRecord
  validates :name, presence: true
  before_create :ensure_meal_time

  has_many :meal_foods, dependent: :destroy
  has_many :foods, through: :meal_foods


  def ensure_meal_time
    self.meal_time ||= Time.now
  end

  def meal_time_since_epoch
    self.meal_time.to_f * 1000
  end

  # MEAL COLLECTED DATA

  def meal_calories
    total_calories = 0
    self.foods.each do |food|
      total_calories += food.calories
    end
    total_calories
  end

  def meal_protein
    total_protein = 0
    self.foods.each do |food|
      total_protein += food.protein
    end
    total_protein
  end

  def meal_carbs
    total_carbs = 0
    self.foods.each do |food|
      total_carbs += food.carbs
    end
    total_carbs
  end

  def meal_fat
    total_fat = 0
    self.foods.each do |food|
      total_fat += food.fat
    end
    total_fat
  end

  # TOTAL COLLECTED DATA

  def self.total_calories
    total_calories = 0
    all_meals = Meal.all
    all_meals.each do |meal|
      total_calories += meal.meal_calories
    end
    total_calories
  end

  def self.total_protein
    total_protein = 0
    all_meals = Meal.all
    all_meals.each do |meal|
      total_protein += meal.meal_protein
    end
    total_protein
  end

  def self.total_carbs
    total_carbs = 0
    all_meals = Meal.all
    all_meals.each do |meal|
      total_carbs += meal.meal_carbs
    end
    total_carbs
  end

  def self.total_fat
    total_fat = 0
    all_meals = Meal.all
    all_meals.each do |meal|
      total_fat += meal.meal_fat
    end
    total_fat
  end

  # AVERAGE COLLECTED DATA

  def self.average_calories_per_meal
    Meal.total_calories / Meal.count
  end

  def self.average_protein_per_meal
    Meal.total_protein / Meal.count
  end

  def self.average_carbs_per_meal
    Meal.total_carbs / Meal.count
  end

  def self.average_fat_per_meal
    Meal.total_fat / Meal.count
  end

  # All food averages

  def self.total_num_meal_food_items
    food_count = 0;
    Meal.all.each do |meal|
      food_count += meal.foods.length
    end
    food_count
  end

  def self.average_calories_per_food
    Meal.total_calories / Meal.total_num_meal_food_items
  end

  def self.average_protein_per_food
    Meal.total_protein / Meal.total_num_meal_food_items
  end

  def self.average_carbs_per_food
    Meal.total_carbs / Meal.total_num_meal_food_items
  end

  def self.average_fat_per_food
    Meal.total_fat / Meal.total_num_meal_food_items
  end
end
