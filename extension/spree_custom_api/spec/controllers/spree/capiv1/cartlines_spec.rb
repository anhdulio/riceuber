require 'rails_helper'

describe 'POST cart#create' do
  let(:cart) {create(:cart_with_lines)}
  context 'given product not available' do
    before {
      @product = create(:product)
      @line = attributes_for(:cart_line, product_id: @product.id, quantity: 1)
    }
    it 'add cart line' do
      expect {
        post v1_cart_cartlines_url(cart.id), params: {cart_line: @line}
      }.to change(cart.cart_lines, :count).by(1)
    end
    it 'update total quantity' do
      expect {
        post v1_cart_cartlines_url(cart.id), params: {cart_line: @line}
        cart.reload
      }.to change(cart, :total).by(@line[:price])
    end
  end
  context 'given product available' do
    before {
      @line = attributes_for(:cart_line, product_id: cart.cart_lines[0].product_id, quantity: 1, price: cart.cart_lines[0].price)
    }
    it 'increase quantity' do
      expect {
        post v1_cart_cartlines_url(cart.id), params: {cart_line: @line}
      }.to change(cart.cart_lines, :count).by(0)
    end
    it 'update total quantity' do
      expect {
        post v1_cart_cartlines_url(cart.id), params: {cart_line: @line}
        cart.reload
      }.to change(cart, :total).by(@line[:price])
    end
  end
  context 'given invalid params' do
  end
end

describe 'PUT cart#update' do
  before {
    @cart = create(:cart_with_lines)
    @line = @cart.cart_lines[0]
  }
  context 'with valid params' do
    it 'update cart line' do
      put v1_cart_cartline_url(@cart.id, @line.id), params: {cart_line: {quantity: 20}}
      @line.reload
      expect(@line.quantity).to eql(20)
    end
    it 'update total quantity' do
      expect {
        put v1_cart_cartline_url(@cart.id, @line.id), params: {cart_line: {quantity: @line.quantity + 100}}
        @cart.reload
      }.to change(@cart, :total).by(100 * @line.price)
    end
  end

  context 'with invalid params' do
  end
end

describe 'DELETE cart#destroy' do
  before {
    @cart = create(:cart_with_lines)
    @line = @cart.cart_lines[0]
  }
  it 'destroys cart line' do
    expect {
      delete v1_cart_cartline_url(@cart.id, @line.id)
    }.to change(CartLine, :count).by(-1)
  end
  it 'update total quantity' do
    expect {
      delete v1_cart_cartline_url(@cart.id, @line.id)
      @cart.reload
    }.to change(@cart, :total).by(-@line.quantity*@line.price)
  end
end
