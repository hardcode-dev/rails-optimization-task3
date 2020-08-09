FactoryBot.define do
  factory :city do
    name { Faker::Address.city.delete(' ') }
  end
end
