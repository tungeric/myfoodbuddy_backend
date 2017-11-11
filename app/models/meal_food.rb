# == Schema Information
#
# Table name: meal_foods
#
#  id         :integer          not null, primary key
#  food_id    :integer
#  meal_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MealFood < ApplicationRecord
  belongs_to :food, validate: true
  belongs_to :meal, validate: true
end
