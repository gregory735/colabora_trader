class Product < ApplicationRecord
  belongs_to :product_category
  belongs_to :collaborator

  validates :name, :price, :amount, :condition, 
            :product_category, :start_date, :end_date, presence: true
end
