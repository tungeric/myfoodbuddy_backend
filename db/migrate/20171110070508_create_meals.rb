class CreateMeals < ActiveRecord::Migration[5.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.datetime :meal_time
      t.timestamps
    end
  end
end
