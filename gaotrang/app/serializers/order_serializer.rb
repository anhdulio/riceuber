class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_number, :total, :adjustment,
             :quantity, :state, :cart, :addresses, :user
  def addresses
    billing = Billing.find_by_order_id(@object.id).as_json
    billing['type'] = 'billing'
    billing.tap{|x| x.delete("payload")}
    shipping = Shipping.find_by_order_id(@object.id).as_json
    shipping['type'] = 'shipping'
    shipping['instruction'] = Shipping.find_by_order_id(@object.id).instruction
    shipping.tap{|x| x.delete("payload")}
    return [shipping,billing]
  end
end
