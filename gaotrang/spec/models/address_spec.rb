require 'rails_helper'

RSpec.describe Address, type: :model do
  it 'has a valid factory' do
    address = create(:address)
    expect(address).to be_valid
  end
  it 'has a valid factory - billing' do
    address = create(:billing_address)
    expect(address).to be_valid
  end
  it 'has a valid factory - shipping' do
    address = create(:shipping_address)
    expect(address).to be_valid
  end
end
