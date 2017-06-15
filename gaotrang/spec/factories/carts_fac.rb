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
            create(:cart_line, cart: cart, product: product)
        end
      end
    end
  end

end
