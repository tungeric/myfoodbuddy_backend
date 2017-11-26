# # defines a new GraphQL type
# Types::FoodType = GraphQL::ObjectType.define do
#   name 'Food'

#   # it has the following fields
#   field :id, !types.ID
#   field :name, !types.String
#   field :amount_g, !types.Int
#   field :calories, types.Int
#   field :protein, types.Int
#   field :carbs, types.Int
#   field :fat, types.Int
#   field :meal_foods, -> { !types[Types::MealFoodType] }
# end

Types::FoodType = GraphQL::ObjectType.define do
  name 'Food'

  # it has the following fields
  field :id, !types.ID
  field :name, !types.String
  field :amount_g, !types.Int
  field :calories, types.Int
  field :protein, types.Int
  field :carbs, types.Int
  field :fat, types.Int
  field :averageness_index, types.Float
  field :meals, !types[Types::MealType] do
     resolve ->(obj, args, ctx) do
       obj.meals
     end
  end
end