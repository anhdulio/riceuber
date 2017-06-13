require 'rails_helper'

describe 'GET products#index' do
  let!(:products) { FactoryGirl.create_list(:product, 10) }

  context 'when no search' do
    it 'returns a success response' do
      get v1_products_url
      # test for the 200 status-code
      expect(response).to be_success
    end
    it 'sends a list of products' do
      get v1_products_url
      expect(json.length).to eq(10)
    end
  end

  context 'when search with valid parameters : name, categories' do
    it 'sends a list of products - 1 param' do
      name = products.first.name
      get v1_products_url, params: { name: name }
      expect(json.size).to eq(Product.search(name: name).size)
    end

    it 'sends a list of products - many params' do
      name = products.first.name
      categories = products.first.categories
      get v1_products_url, params: { name: name, categories: categories }
      expect(json.size).to eq(Product.search(name: name, categories: categories).size)
    end

    it 'sends list with no product' do
      name = 'Lio!2'
      get v1_products_url, params: { name: name }
      expect(json.length).to eq(0)
    end
  end

  context 'when search with invalid parameters' do
    it 'sends list with no product' do
      get v1_products_url, params: { randomparam: 'abc' }
      expect(json.length).to eq(10)
    end
  end

end

describe 'GET product#show' do
  it 'returns a success response' do
    product = create(:product)
    get v1_product_url(product.id)
    expect(response).to be_success
  end
  it 'returns id, name, description, available_on, slug,
  categories, meta_description, meta_keywords, price, img_url_sml,
  img_url_med, img_url_lrg' do
    keys = %w[id name description available_on slug categories meta_description
              meta_keywords price img_url_sml img_url_med img_url_lrg]
    product = create(:product)
    get v1_product_url(product.id)
    expect(json.keys).to eq(keys)
  end
end

describe 'POST product#create' do
  context 'with valid params' do
    it 'create a new product' do
      expect {
        post v1_products_url, params: {product: attributes_for(:product)}
      }.to change(Product, :count).by(1)
    end
    it 'renders a json response with the new product' do
      post v1_products_url, params: {product: attributes_for(:product)}
      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq('application/json')
      expect(response.location).to eq(v1_product_url(Product.last))
    end
  end
  context 'with invalid params' do
    it "renders a JSON response with errors for the new product" do
      post v1_products_url, params: {product: attributes_for(:product, available_on: 'string')}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq('application/json')
    end

  end
end

describe 'PUT product#update' do
  context 'with valid params' do
      it "updates the requested product" do
        product = create(:product)
        product_attribute = attributes_for(:product)
        put v1_product_url(product.id), params: {product: product_attribute}
        product.reload
        expect(product.name).to eql(product_attribute[:name])
      end

      it "renders a JSON response with the product" do
        product = create(:product)
        put v1_product_url(product.id), params: {product: attributes_for(:product)}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
  end
  context 'with invalid params' do
      it "renders a JSON response with errors for the product" do
        product = create(:product)
        put v1_product_url(product.id), params: {product: attributes_for(:product, available_on: 'string')}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
  end
end

describe 'DELETE product#destroy' do
  it 'destroys the requested product' do
    product = create(:product)
    expect {
        delete v1_product_url(product.id)
    }.to change(Product, :count).by(-1)
  end
end