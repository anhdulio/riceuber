class Cart < ApplicationRecord
  before_save :update_total
  has_many :cart_lines
  has_many :products, through: :cart_lines
  belongs_to :order
  validates_numericality_of :total,
                            greater_than_or_equal_to: 0,
                            on: :update, message: "can't be negative number"

  def update_total
    total = 0
    self.cart_lines.each do |line|
      total += line.quantity * line.price
    end
    self.total = total
  end

end
