class Resolvers::CreateMeal < GraphQL::Function
  argument :name, types.String
  argument :meal_time, types.Float

  type Types::MealType

  def call(obj, args, ctx)
    meal = Meal.new(
      name: args[:name],
      meal_time: Time.at(args[:meal_time]/1000),
      )
    if meal.save
      return meal
    else
      return GraphQL::ExecutionError.new("Invalid input: #{meal.errors.full_messages.join(', ')}")
    end
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end