# defines a new GraphQL type
Types::MealFoodType = GraphQL::ObjectType.define do
  name 'MealFood'

  # it has the following fields
  field :id, !types.ID
  field :food_id, !types.Int
  field :meal_id, !types.Int
end