FactoryGirl.define do
  factory :user do
    name  'Anh Du'
    email { Faker::Internet.email }
  end
end
