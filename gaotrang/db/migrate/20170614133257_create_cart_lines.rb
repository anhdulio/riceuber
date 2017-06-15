class CreateCartLines < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_lines do |t|
      t.integer :quantity
      t.float   :price
      t.belongs_to :product, index: true
      t.belongs_to :cart, index: true
      t.timestamps
    end
  end
end
