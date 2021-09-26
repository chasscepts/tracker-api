FactoryBot.define do
  factory :user do
    email { 'test222@exp.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
