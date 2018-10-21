User.create!(first_name: 'Lali',
             last_name: 'Bear',
             email: 'lali20021@gmail.com',
             password: 'password',
             password_confirmation: 'password',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "test-#{n+1}@example.com"
  password = 'password'
  User.create!(first_name: first_name,
               last_name: last_name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
