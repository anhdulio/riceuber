class AddIndexToProductsSlug < ActiveRecord::Migration[5.0]
  def change
    add_index :products, :slug
  end
end
