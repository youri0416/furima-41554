FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    email { Faker::Internet.email }
    password { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name { '山田' }
    first_name { '花子' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'ハナコ' }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
