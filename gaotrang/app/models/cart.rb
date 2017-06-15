class Cart < ApplicationRecord
  has_many :cart_lines
  has_many :products, through: :cart_lines
  validates_numericality_of :total,
                            greater_than_or_equal_to: 0,
                            on: :update, message: "can't be negative number"
  def update_total!
    update_total
    self.save
  end

  def update_total
    total = 0
    self.cart_lines.each do |line|
      total += line.quantity * line.price
    end
    self.total = total
  end

end
