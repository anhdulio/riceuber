class AddOrderToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :order, foreign_key: true
  end
end
