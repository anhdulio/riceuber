FactoryGirl.define do
  factory :product do
    name              {Faker::LeagueOfLegends.champion}
    description       {Faker::LeagueOfLegends.quote}
    available_on      {Faker::Time.between(DateTime.now - 1, DateTime.now)}
    slug              {}
    categories        {Faker::LeagueOfLegends.location}
    meta_description  {Faker::LeagueOfLegends.quote}
    meta_keywords     {5.times {Faker::LeagueOfLegends.champion}}
    price             {Faker::Number(5)}
    payload           {}
  end
end
