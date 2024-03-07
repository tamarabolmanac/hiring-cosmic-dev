FactoryBot.define do 
  factory :employee do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Date.new(1994, 1, 1)}
    country { "Serbia" }
    address { "Address example 1" }
    bio { "Something about the employee" }
    external_id { 1234567 }
  end
end
