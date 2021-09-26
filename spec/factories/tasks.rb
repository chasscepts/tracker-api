FactoryBot.define do
  factory :task do
    title { Faker::Lorem.word }
    group_id { nil }
    user_id { nil }
  end
end
