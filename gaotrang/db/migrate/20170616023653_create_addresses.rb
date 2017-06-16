class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :line_1
      t.string :line_2

      t.timestamps
    end
  end
end
