FactoryBot.define do
  factory :user do
    username { Faker::Lorem.unique.word }
    display_name { Faker::Name.unique.name }
    email { Faker::Lorem.unique.word }
    password 'foobar'
  end
end
