class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.string :total
      t.string :adjustment
      t.string :quantity
      t.string :state

      t.timestamps
    end
  end
end
