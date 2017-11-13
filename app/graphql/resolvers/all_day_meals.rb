require 'search_object/plugin/graphql'

class Resolvers::AllDayMeals
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { Meal.all }

  # return type
  type !types[Types::MealType]

  # inline input type definition for the advance filter
  DayMealFilter = GraphQL::InputObjectType.define do
    name 'DayMealFilter'
    argument :meal_time_after, types.Float
    argument :meal_time_before, types.Float
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :filter, type: DayMealFilter, with: :apply_filter

  # apply_filter recursively loops through "OR" branches
  def apply_filter(scope, value)
    # normalize filters from nested OR structure, to flat scope list
    branches = normalize_filters(value)#.reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    # add like SQL conditions
    scope = Meal.all
    scope = scope.where('meal_time_since_epoch between ? and ?', "%#{value['meal_time_after']}%", "%#{value['meal_time_before']}%") if value['meal_time_after'] && value['meal_time_before']

    branches << scope

    # # continue to normalize down
    # value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end

end