class AddDistrictToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :district, :string
  end
end
