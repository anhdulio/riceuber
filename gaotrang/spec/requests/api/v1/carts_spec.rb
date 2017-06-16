require 'rails_helper'

describe 'GET cart#show' do
  it 'returns a success response' do
    cart = create(:cart)
    get v1_cart_url(cart.id)
    expect(response).to be_success
  end
  it 'returns id total cart_lines' do
    keys = %w[id total cart_lines]
    cart = create(:cart_with_lines)
    get v1_cart_url(cart.id)
    expect(json.keys).to eq(keys)
  end
end

describe 'POST cart#create' do
    it 'creates a new cart' do
      expect {
        post v1_carts_url
      }.to change(Cart, :count).by(1)
    end
    it 'renders a cart unique id' do
      post v1_carts_url
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json')
      expect(json.keys.first).to eq('cart_id')
    end
end

describe 'PUT cart#update' do
  let!(:new_cart) {FactoryGirl.create(:cart, total: 0)}
  context 'with valid params' do
    it 'add item to cart' do
      product = create(:product)
      cart_line = build(:cart_line, product_id: product.id)
      total = new_cart.update_total
      expect {
        put v1_cart_url(new_cart.id), params: { cart_action: 'add', cart_line: cart_line.as_json }
      }.to change(CartLine, :count).by(1)
      expect(json['total']).not_to eql(total), "total not update #{json['total']} vs #{total}"
    end
    it 'change quantity given item existss' do
      product = create(:product)
      cart_line = create(:cart_line, product_id: product.id, cart_id: new_cart.id, quantity: 1)
      total = new_cart.update_total
      put v1_cart_url(new_cart.id), params: { cart_action: 'add', cart_line: cart_line.as_json }
      cart_line.reload
      expect(cart_line.quantity).to eql(2)
      expect(json['total']).not_to eql(total), "total not update #{json['total']} vs #{total}"
    end
    it 'remove items from cart' do
      product = create(:product)
      cart_line = create(:cart_line, product_id: product.id, cart_id: new_cart.id)
      total = new_cart.update_total
      expect {
        put v1_cart_url(new_cart.id), params: { cart_action: 'remove', cart_line: cart_line.as_json }
      }.to change(new_cart.cart_lines, :count).by(-1)
      expect(json['total']).not_to eql(total), "total not update #{json['total']} vs #{total}"
    end
    it 'change cart quantity' do
      product = create(:product)
      cart_line = create(:cart_line, product_id: product.id, cart_id: new_cart.id, quantity: 2)
      cart_line.quantity = 3
      total = new_cart.update_total
      put v1_cart_url(new_cart.id), params: { cart_action: 'update', cart_line: cart_line.as_json }
      cart_line.reload
      expect(cart_line.quantity).to eql(3)
      expect(json['total']).not_to eql(total), "total not update #{json['total']} vs #{total}"
    end
  end

  context 'with invalid params' do
    it 'cart actions not in [add, remove, update]' do
      product = create(:product)
      cart_line = build(:cart_line, product_id: product.id)
      put v1_cart_url(new_cart.id), params: { cart_action: 'otheraction', cart_line: cart_line.as_json }
      expect(response.status).to eql(422)
      expect(json['message']).to eql('invalid action')
    end
  end
end

describe 'POST cart#checkout' do
  let!(:cart) {FactoryGirl.create(:cart_with_lines)}
  let!(:user) {FactoryGirl.build(:user).as_json}
  let!(:shipping_address) {FactoryGirl.build(:shipping_address).as_json}
  let!(:billing_address) {FactoryGirl.build(:billing_address).as_json}
  it 'convert cart to order' do
    expect {
      post v1_cart_checkout_url(cart.id), params: { cart_action: 'checkout', user: user,
                                                    shipping_address: shipping_address,
                                                    billing_address: billing_address}
    }.to change(Order, :count).by(1)
    expect(json['state']).to eql('open')
  end

  it 'render orders' do
    keys = %w[id order_number total adjustment  quantity state cart addresses user]
    post v1_cart_checkout_url(cart.id), params: { cart_action: 'checkout', user: user,
                                                  shipping_address: shipping_address,
                                                  billing_address: billing_address}
    expect(json.keys).to eq(keys)
  end

end

describe 'DELETE cart#destroy' do
  it 'destroys the requested cart' do
    cart = create(:cart)
    expect {
        delete v1_cart_url(cart.id)
    }.to change(Cart, :count).by(-1)
  end
end