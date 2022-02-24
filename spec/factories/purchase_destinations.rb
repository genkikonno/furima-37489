FactoryBot.define do
  factory :purchase_destination do
    user_id { Faker::Number.non_zero_digit }
    item_id { Faker::Number.non_zero_digit }
    post_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    phone_number {'09000000000'}
    token {"tok_abcdefghijk00000000000000000"}

  end
end
