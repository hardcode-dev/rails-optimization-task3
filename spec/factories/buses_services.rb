FactoryBot.define do
  factory :buses_service do
    association(:bus)
    association(:service)
  end
end
