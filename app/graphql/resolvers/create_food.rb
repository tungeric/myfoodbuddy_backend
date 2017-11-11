class Resolvers::CreateFood < GraphQL::Function
  argument :name, !types.String
  argument :category, types.String
  argument :amount_g, !types.Int
  argument :calories, types.Int
  argument :protein, types.Int
  argument :carbs, types.Int
  argument :fat, types.Int

  type Types::FoodType

  def call(obj, args, ctx)
    food = Food.new(
      name: args[:name],
      amount_g: args[:amount_g],
      category: args[:category],
      calories: args[:calories],
      protein: args[:protein],
      carbs: args[:carbs],
      fat: args[:fat],
      )
    if food.save
      return food
    else
      return GraphQL::ExecutionError.new("Invalid input: #{food.errors.full_messages.join(', ')}")
    end
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.full_messages.join(', ')}")
  end
end