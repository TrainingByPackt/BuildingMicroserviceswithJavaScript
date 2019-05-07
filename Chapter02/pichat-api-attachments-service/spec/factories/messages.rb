FactoryBot.define do
  factory :message do
    body { Faker::Lorem.paragraph(3) }
    user factory: :user
  end
end
