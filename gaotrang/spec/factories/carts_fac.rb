FactoryGirl.define do
  factory :cart do
    total {0}
    factory :cart_with_lines do
      transient do
        lines_count 3
      end
      after(:create) do |cart, evaluator|
        evaluator.lines_count.times do
            product = create(:product)
            cart_line = build(:cart_line, product: product)
            cart.cart_lines << cart_line
        end
        cart.save
      end
    end
  end
end
