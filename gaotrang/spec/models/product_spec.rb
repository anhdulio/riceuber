require 'rails_helper'
require 'byebug'
RSpec.describe Product, type: :model do
  it 'has a valid factory' do
    product = create(:product)
    expect(product).to be_valid
  end
  context 'Invalid fields' do
    it 'mandatory fields' do
      product = Product.new
      product.name = nil
      product.description = nil
      product.available_on = nil
      product.slug = 'slug'
      product.categories = nil
      product.meta_description = nil
      product.meta_keywords = nil
      product.price = nil
      expect(product.save).to eq(false)
    end
    it 'valid date fields' do
      product = build(:product, available_on: 'string')
      expect(product.save).to eq(false)
    end
    it 'valid number fields' do
      producta = build(:product, price: 'string')
      productb = build(:product, price: '-2')
      expect(producta.save).to eq(false)
      expect(productb.save).to eq(false)
    end
    it 'valid image url'
  end
  context 'Valid fields' do
    let(:product) {FactoryGirl.build(:product)}
    it 'should save to database' do
      expect(product.save).to eq(true)
    end
  end

  it "search function - santinize ', %"
end
