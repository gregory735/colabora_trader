class AddNameToProductCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :product_categories, :name, :string
  end
end
