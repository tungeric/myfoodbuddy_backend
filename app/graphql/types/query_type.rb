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

  field :allMealFoods, !types[Types::MealFoodType] do
    resolve -> (obj, args, ctx) { MealFood.all }
  end

  field :allDayMeals, function: Resolvers::MealsSearch
  field :foodSearch, function: Resolvers::FoodSearch

  field :topMostAverageFoods, !types[Types::FoodType] do
    argument :limit, types.Int, default_value: 5, prepare: -> (limit){ limit }
    resolve -> (obj, args, ctx) {
      Food.sort_by_averageness_index(args[:limit])
    }
  end
  
end
