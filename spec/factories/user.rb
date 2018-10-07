FactoryBot.define do
  factory :user do
    first_name { 'Jane' }
    last_name { 'Doe' }
    email { 'jane@example.com' }
    password { 'password' }
    password_confirmation { 'password' }

  factory :invalid_user do
    first_name { 'J' }
    last_name { 'D' }
    email { 'jane_at_example.com' }
    password { 'pa' }
    password_confirmation { 'pa' }
  end
end
end 
