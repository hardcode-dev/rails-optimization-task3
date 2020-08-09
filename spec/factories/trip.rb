FactoryBot.define do
  factory :trip do
    from_id { nil }
    to_id { nil }
    start_time { '11:00' }
    duration_minutes { 168 }
    price_cents { 173 }
    bus_id { nil }
  end
end
