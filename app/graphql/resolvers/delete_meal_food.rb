class Resolvers::DeleteMealFood < GraphQL::Function
  argument :mealfood_id, !types.Int

  type Types::MealFoodType

  def call(obj, args, ctx)
    meal_food = MealFood.find(args[:mealfood_id])
    meal_food.destroy!
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end