class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_number, :total, :adjustment,
             :quantity, :state, :cart, :addresses, :user
  def addresses
    billing = Billing.find_by_order_id(@object.id).as_json
    billing['type'] = 'billing'
    shipping = Shipping.find_by_order_id(@object.id).as_json
    shipping['type'] = 'shipping'
    return [shipping,billing]
  end
end
