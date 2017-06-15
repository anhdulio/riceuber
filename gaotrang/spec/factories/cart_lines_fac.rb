FactoryGirl.define do
  factory :cart_line do
    product_id  {1}
    cart_id     {1}
    quantity    {Faker::Number.between(1, 20)}
    price       {Faker::Number.between(8000, 12000)}
  end
end
