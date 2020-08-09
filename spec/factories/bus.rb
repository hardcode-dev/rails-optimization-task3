FactoryBot.define do
  factory :bus do
    number { Faker::Number.number(digits: 10) }
    model { 'Сканиа' }
  end
end
