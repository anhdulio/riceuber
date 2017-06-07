require 'rails_helper'

describe 'Products API' do
  it 'sends a list of products' do
    FactoryGirl.create_list(:product, 10)
    get v1_products_url

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of messages are returned
    expect(json.length).to eq(10)
  end
end
