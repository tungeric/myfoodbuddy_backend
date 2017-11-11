Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createFood, function: Resolvers::CreateFood.new
  field :createMeal, function: Resolvers::CreateMeal.new

end
