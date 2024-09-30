FactoryBot.define do
  factory :order_purchase do
    post_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" } # ここを修正
    prefecture_id { Faker::Number.between(from: 2, to: 47) }
    city { Faker::Address.city }
    street_address { Faker::Address.street_address }
    building { Faker::Address.building_number }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164[1..11] }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
