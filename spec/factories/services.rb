FactoryBot.define do
  factory :service do
    name { Service::SERVICES.sample }
  end
end
