class Resolvers::DeleteMealFood < GraphQL::Function
  argument :id, !types.Int

  type types.Boolean

  def call(obj, args, ctx)
    meal_food = MealFood.find_by(
      id: args[:id]
      )
    if meal_food.destroy
      return true
    else
      return GraphQL::ExecutionError.new("Invalid input: #{meal_food.errors.full_messages.join(', ')}")
    end
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end