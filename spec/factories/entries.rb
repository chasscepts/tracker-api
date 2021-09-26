FactoryBot.define do
  factory :entry do
    duration { Faker::Number.number(digits: 5) }
    entry_date { Faker::Date.in_date_period }
    task_id { nil }
  end
end
