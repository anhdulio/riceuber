FactoryGirl.define do
  factory :product do
    name              { Faker::LeagueOfLegends.champion }
    description       { Faker::LeagueOfLegends.quote }
    available_on      { Faker::Date.between(DateTime.now - 1, DateTime.now) }
    slug              {}
    categories        { Faker::LeagueOfLegends.location }
    meta_description  { Faker::LeagueOfLegends.quote }
    meta_keywords     { 5.times { Faker::LeagueOfLegends.champion } }
    price             { Faker::Number.number(5) }
    img_url_sml       { Faker::LoremPixel.image('400x400')}
    img_url_med       { Faker::LoremPixel.image('800x800')}
    img_url_lrg       { Faker::LoremPixel.image('800x800')}
  end
end
