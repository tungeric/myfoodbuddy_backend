# # defines a new GraphQL type
# Types::MealType = GraphQL::ObjectType.define do
#   name 'Meal'

#   # it has the following fields
#   field :id, !types.ID
#   field :name, types.String
#   field :meal_time, !Types::DateTimeType
#   field :meal_foods, -> { !types[Types::MealFoodType] }
# end

# defines a new GraphQL type
Types::MealType = GraphQL::ObjectType.define do
  name 'Meal'

  # it has the following fields
  field :id, !types.ID
  field :name, types.String
  field :meal_time, !Types::DateTimeType
  field :foods, !types[Types::FoodType] do
     resolve ->(obj, args, ctx) do
       obj.foods
     end
  end
end