class CartSerializer < ActiveModel::Serializer
  attributes :id, :total, :cart_lines

end
