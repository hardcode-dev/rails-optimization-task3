FactoryBot.define do
  factory :trip do
    association :from, factory: :city
    association :to, factory: :city
    association :bus
    start_time { "12:00" }
    duration_minutes { 120 }
    price_cents { 10000 }
  end
end
