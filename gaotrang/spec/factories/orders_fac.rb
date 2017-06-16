FactoryGirl.define do
  factory :order do
    order_number { "ORD#{Faker::Number.number(10)}" }
    total        { Faker::Number.positive }
    adjustment   { Faker::Number.negative }
    quantity     { Faker::Number.number(1) }
    state        'open'
    factory :order_complete do
      after(:create) do |order|
        create(:cart_with_lines, order: order)
        create(:billing_address, order: order)
        create(:shipping_address, order: order)
        create(:user, order: order)
      end
    end
  end
end