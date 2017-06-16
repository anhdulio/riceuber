class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_number, :total, :adjustment,
             :quantity, :state, :cart, :addresses, :user
end
