# == Schema Information
#
# Table name: foods
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  amount_g   :integer          default(1), not null
#  calories   :integer          default(0)
#  protein    :integer          default(0)
#  carbs      :integer          default(0)
#  fat        :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :string
#

class Food < ApplicationRecord
  validates :name, :amount_g, presence: true

  has_many :meal_foods
  has_many :meals, through: :meal_foods
end
