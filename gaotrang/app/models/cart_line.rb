class CartLine < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  validates_numericality_of :price,
                          greater_than_or_equal_to: 0,
                          on: :create, message: "can't be negative number"
  validates_numericality_of :quantity,
                          greater_than_or_equal_to: 0,
                          only_integer: true,
                          on: :create, message: "can't be negative number"
end
