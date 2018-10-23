FactoryBot.define do
  factory :user do
    first_name { 'Jane' }
    last_name { 'Doe' }
    email { 'jane@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
    activated { false }

    factory :other_user do
      first_name { 'Jon' }
      last_name { 'Doee' }
      email { 'jon@example.com' }
      password { 'password' }
      password_confirmation { 'password' }
      admin { false }
      activated { true }

    factory :admin do
      first_name { 'Jay' }
      last_name { 'Yay' }
      email { 'jay@example.com' }
      password { 'password' }
      password_confirmation { 'password' }
      admin { true }
      activated { true }

  factory :invalid_user do
    first_name { 'J' }
    last_name { 'D' }
    email { 'jane_at_example.com' }
    password { 'pa' }
    password_confirmation { 'pa' }
  end
end
end
end
end
