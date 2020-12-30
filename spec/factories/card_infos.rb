FactoryBot.define do
  factory :card_info do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code {"000-0000"}
    prefecture_id {Faker::Number.between(from:2, to:48)}
    city {Gimei.address.city.kanji}
    addresses {Faker::Lorem.sentence}
    phone_number {"00000000"}
    association :user
    association :item
  end

end