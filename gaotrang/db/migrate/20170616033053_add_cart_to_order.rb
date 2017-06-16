class AddCartToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :carts, :order, foreign_key: true, index: true
  end
end
