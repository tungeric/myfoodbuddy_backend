class Resolvers::DeleteMealFood < GraphQL::Function
  argument :food_id, !types.Int
  argument :meal_id, !types.Int

  type Types::MealFoodType

  def call(obj, args, ctx)
    meal_food = MealFood.where(:food_id=>args[:food_id]).where(:meal_id=>args[:meal_id]).first
    meal_food.destroy!
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end