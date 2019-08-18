FactoryBot.define do
  factory :trip do
    association :from, factory: :city
    association :to, factory: [:city, :owlet]
    start_time {"18:12"}
    duration_minutes { 115 }
    price_cents { 100 }
    bus
  end
end