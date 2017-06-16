class Order < ApplicationRecord
  before_save :update_total, :update_quantity, :generate_order_number
  has_one :cart
  has_many :addresses
  has_one :user

  private
  def update_total
    total = 0
    self.cart.cart_lines.each do |line|
      total += line.quantity * line.price
    end
    self.total = total
  end

  def update_quantity
    quantity = 0
    self.cart.cart_lines.each do |line|
      quantity += line.quantity
    end
    self.quantity = quantity
  end

  def generate_order_number
    unless self.order_number
      order_number = SecureRandom.base58(8).upcase
      while Order.where(order_number: order_number).first do
        order_number = SecureRandom.base58(8).upcase
      end
      self.order_number = order_number
    end
  end

end
