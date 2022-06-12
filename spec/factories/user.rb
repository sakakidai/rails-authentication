Faker::Config.locale = 'en'

FactoryBot.define do
  factory :user do
    transient do
      name_en { Faker::Name.unique.first_name }
    end
    
    name { name_en }
    email { "#{name_en}@exmaple.com" }
    password { "password" }
    activated { true }
  end
end