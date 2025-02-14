FactoryBot.define do
  factory :service do
    initialize_with do
      Service.find_or_create_by(name:)
    end

    name { Service::SERVICES.sample }
  end
end