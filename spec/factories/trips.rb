FactoryBot.define do
  factory :trip do
    from
    to
    bus
    start_time { "09:00" }
    duration_minutes { rand(1000) + 1 }
    price_cents { rand(100000) }
  end
end