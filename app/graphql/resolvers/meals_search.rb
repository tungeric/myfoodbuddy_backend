require 'search_object/plugin/graphql'

class Resolvers::MealsSearch
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { Meal.all }

  # return type
  type !types[Types::MealType]

  # inline input type definition for the advance filter
  MealFilter = GraphQL::InputObjectType.define do
    name 'MealFilter'
    argument :OR, -> { types[MealFilter] }
    # argument :name, types.String
    argument :meal_time_after, types.Float
    argument :meal_time_before, types.Float
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :filter, type: MealFilter, with: :apply_filter

  # apply_filter recursively loops through "OR" branches
  def apply_filter(scope, value)
    # normalize filters from nested OR structure, to flat scope list
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    # add like SQL conditions
    scope = Meal.all
    day_start = Time.at(value['meal_time_after']/1000)
    day_end = Time.at(value['meal_time_before']/1000)
    scope = scope.where('meal_time between ? and ?', "%#{day_start}%", "%#{day_end}%") if value['meal_time_after'] && value['meal_time_before']
    # scope = scope.where('meal_time BETWEEN day_start AND day_end') if day_start && day_end
    # scope = scope.where('name LIKE "Chicken"') if day_start && day_end
    # scope = scope.where('name LIKE ?', "%#{value['name']}%") if value['name']

    branches << scope

    # # continue to normalize down
    value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end

end