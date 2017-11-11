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

require 'test_helper'

class MealFoodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
