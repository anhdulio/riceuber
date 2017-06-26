require 'rails_helper'

RSpec.describe Cart, type: :model do
  it 'has a valid factory' do
    cart = create(:cart)
    expect(cart).to be_valid
  end

  it 'create cart with lines with total' do
    cart = create(:cart_with_lines)
    expect(cart.total).not_to eq(0)
  end

  context 'Invalid fields' do
    it 'valid number fields' do
      carta = create(:cart, total: 3)
      cartb = create(:cart, total: 5)
      carta.total = 'string'
      cartb.total = '-2'
      expect(carta.save).to eq(false)
      expect(cartb.save).to eq(false)
    end
  end

end
