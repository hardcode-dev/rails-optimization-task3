FactoryBot.define do
  factory :city, aliases: [:from, :to] do
    initialize_with do
      City.find_or_create_by(name:)
    end

    name { ['Тюмень', 'Тобольск', 'Екатеринбург'].sample }
  end
end