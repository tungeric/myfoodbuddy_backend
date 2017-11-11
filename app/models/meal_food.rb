class MealFood < ApplicationRecord
  belongs_to :food, validate: true
  belongs_to :meal, validate: true
end
