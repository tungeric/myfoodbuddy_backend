class AddCategoryToFood < ActiveRecord::Migration[5.1]
  def change
    add_column :foods, :category, :string
  end
end
