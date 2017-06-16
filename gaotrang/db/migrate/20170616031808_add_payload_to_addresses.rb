class AddPayloadToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :payload, :json
  end
end
