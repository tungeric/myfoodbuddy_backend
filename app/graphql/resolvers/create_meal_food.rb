class Resolvers::CreateMealFood < GraphQL::Function
  argument :food_id, !types.Int
  argument :meal_id, !types.Int
  argument :num_servings, !types.Int

  type Types::MealFoodType

  def call(obj, args, ctx)
    meal_food = MealFood.new(
      food_id: args[:food_id],
      meal_id: args[:meal_id],
      num_servings: args[:num_servings]
      )
    if meal_food.save
      return meal_food
    else
      return GraphQL::ExecutionError.new("Invalid input: #{meal_food.errors.full_messages.join(', ')}")
    end
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end