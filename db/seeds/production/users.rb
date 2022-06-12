Faker::Config.locale = 'en'

10.times do |n|
  name = Faker::Name.unique.first_name
  User.create!(
    name: name,
    email: "#{name}@example.com",
    password: "password",
    activated: true
  )
end

puts "users = #{User.count}"
