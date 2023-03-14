FactoryBot.define do
  factory :trip do
    association(:from, factory: :city)
    association(:to, factory: :city)
    association(:bus)

    start_time { Time.now.strftime("%H:%M") }
    duration_minutes { rand(30..100) }
    price_cents { rand(500..1000) }
  end
end
