class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :available_on
      t.string :slug
      t.string :meta_description
      t.string :meta_keywords
      t.json :payload

      t.timestamps
    end
  end
end
