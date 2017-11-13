Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :allFoods, !types[Types::FoodType] do
    resolve -> (obj, args, ctx) { Food.all }
  end

  field :allMeals, !types[Types::MealType] do
    resolve -> (obj, args, ctx) { Meal.all }
  end

  field :allDayMeals, function: Resolvers::MealsSearch
  
end
