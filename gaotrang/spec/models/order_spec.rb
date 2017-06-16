require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'has a valid factory' do
    order = create(:order)
    expect(order).to be_valid
  end
  it 'has a valid factory - complete' do
    order = create(:order_complete)
    expect(order).to be_valid
  end
end
