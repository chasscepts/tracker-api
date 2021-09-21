FactoryBot.define do
  factory :default_task do
    title { Faker::Lorem.word }
    group_id { nil }
  end
end
