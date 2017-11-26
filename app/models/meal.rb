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

  def meal_data
    meal_data = Hash.new(0)
    self.foods.each do |food|
      meal_data["total_calories"] += food.calories
      meal_data["total_protein"] += food.protein
      meal_data["total_carbs"] += food.carbs
      meal_data["total_fat"] += food.fat
    end
    meal_data
  end

  # TOTAL COLLECTED DATA

  def self.cumulative_data
    cumulative_data = Hash.new(0)
    all_meals = Meal.all
    all_meals.each do |meal|
      cumulative_data["total_calories"] += meal.meal_data["total_calories"]
      cumulative_data["total_protein"] += meal.meal_data["total_protein"]
      cumulative_data["total_carbs"] += meal.meal_data["total_carbs"]
      cumulative_data["total_fat"] += meal.meal_data["total_fat"]
    end
    cumulative_data
  end

  # AVERAGE COLLECTED DATA

  def self.average_data_per_meal
    num_meals = Meal.count
    average_data_per_meal = Hash.new
    Meal.cumulative_data.each do |key, value| 
      average_data_per_meal[key]= value / num_meals
    end
    average_data_per_meal
  end

  # All food averages

  def self.total_num_meal_food_items
    food_count = 0;
    Meal.all.each do |meal|
      food_count += meal.foods.length
    end
    food_count
  end

  def self.average_food_data
    num_foods = Meal.total_num_meal_food_items
    average_food_data = Hash.new
    Meal.cumulative_data.each do |key, value|
      average_food_data[key] = value / num_foods
    end
    average_food_data
  end

end
