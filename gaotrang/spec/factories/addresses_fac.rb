FactoryGirl.define do
  factory :address_billing, class: 'Billing' do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    company_name  { Faker::Company.name }
    line_1        { Faker::Address.street_address }
    line_2        { Faker::Address.secondary_address }
    district      { Faker::Address.city }
  end
end

FactoryGirl.define do
  factory :address_shipping, class: 'Shipping' do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    company_name  { Faker::Company.name }
    line_1        { Faker::Address.street_address }
    line_2        { Faker::Address.secondary_address }
    district      { Faker::Address.city }
    instruction   'Call me 0939024961'
  end
end