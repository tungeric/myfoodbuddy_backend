# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Food.destroy_all
Meal.destroy_all
MealFood.destroy_all

FOOD_CATEGORY = ['Meat', 'Vegetables', 'Fruit', 'Grain', 'Misc']

30.times do 
  food = Food.create(name: Faker::Food.ingredient,
                     category: FOOD_CATEGORY.sample, 
                     amount_g: rand(1..10),
                     calories: rand(1..300),
                     protein: rand(0..40),
                     carbs: rand(0..100),
                     fat: rand(0..20)
                     )
end

MEAL_NAMES = ['Breakfast', 'Lunch', 'Dinner', 'Brunch', 'Snack']

30.times do
  meal = Meal.create(name: MEAL_NAMES.sample,
                     meal_time: Time.new(2017,11,rand(1..12), rand(0..23), rand(0..59), rand(0..59))
  )
end

food_first = Food.first.id 
food_last = Food.last.id
meal_first = Meal.first.id
meal_last = Meal.last.id

100.times do
  mealfood = MealFood.create(food_id: rand(food_first..food_last),
                             meal_id: rand(meal_first..meal_last),
                             num_servings: rand(1..5)
                             )
end
                    