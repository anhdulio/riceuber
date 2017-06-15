require 'rails_helper'

RSpec.describe CartLine, type: :model do
  it 'has a valid factory' do
    cart_line = create(:cart_line)
    expect(cart_line).to be_valid
  end

  context 'Invalid fields' do
    it 'valid number fields' do
      cart_linea = build(:cart_line, price: 'string')
      cart_lineb = build(:cart_line, price: '-2')
      expect(cart_linea.save).to eq(false)
      expect(cart_lineb.save).to eq(false)
    end
  end
end
