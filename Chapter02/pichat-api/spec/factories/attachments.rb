FactoryBot.define do
  factory :attachment do
    media_type { Faker::Number.between(1, 2) }
    file_name { Faker::Lorem.word }
    url { Faker::Lorem.word }
    message factory: :message
  end
end
