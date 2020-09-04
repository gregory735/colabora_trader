class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :price
      t.string :name
      t.integer :amount
      t.references :product_category, null: false, foreign_key: true
      t.references :collaborator, null: false, foreign_key: true
      t.boolean :condition
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
