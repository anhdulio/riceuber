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
    context 'given no cart line' do
      it 'creates a new cart' do
        expect {
          post v1_carts_url
        }.to change(Cart, :count).by(1)
      end
      it 'renders a cart unique id' do
        post v1_carts_url
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(json.keys.first).to eq('id')
      end
    end
    context 'given cart lines' do
      before {
        product1 = create(:product)
        product2 = create(:product)
        @cart_lines = []
        @cart_lines << attributes_for(:cart_line, product_id: product1.id)
        @cart_lines << attributes_for(:cart_line, product_id: product2.id)
      }
      it 'creates a new cart' do
        expect {
          post v1_carts_url, params: {cart_lines: @cart_lines.as_json}
        }.to change(Cart, :count).by(1)
      end
      it 'creates a new cart with lines' do
        post v1_carts_url, params: {cart_lines: @cart_lines}
        expect(Cart.first.cart_lines.size).to eql(2)
      end
    end
end

describe 'PUT cart#update' do
  let!(:new_cart) {FactoryGirl.create(:cart, total: 0)}
  context 'with valid params' do
    it 'replace all cart' do
      cart = create(:cart_with_lines)
      product1 = create(:product, name: "gao trang")
      cart_lines = []
      cart_lines << attributes_for(:cart_line, product_id: product1.id)
      put v1_cart_url(cart.id), params: {cart_lines: cart_lines.as_json}
      cart.reload
      expect(cart.products.first.name).to eql("gao trang")
    end
  end

  context 'with invalid params' do
  end
end

describe 'POST cart#checkout' do
  let!(:cart) {FactoryGirl.create(:cart_with_lines)}
  let!(:user) {FactoryGirl.build(:user).as_json}
  let!(:shipping_address) {FactoryGirl.attributes_for(:address_shipping)}
  let!(:billing_address) {FactoryGirl.attributes_for(:address_billing)}
  it 'convert cart to order' do
    shipping_address[:type] = :shipping
    billing_address[:type] = :billing
    expect {
      post v1_cart_checkout_url(cart.id), params: { user: user,
                                                    addresses: [shipping_address,billing_address]
                                                  }
    }.to change(Order, :count).by(1)
    expect(json['state']).to eql('open')
  end

  it 'render orders' do
    keys = %w[id order_number total adjustment quantity state cart addresses user]
    shipping_address[:type] = :shipping
    billing_address[:type] = :billing
    post v1_cart_checkout_url(cart.id), params: { user: user,
                                                  addresses: [shipping_address,billing_address]
                                                }
    expect(json.keys).to eq(keys)
    puts json
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