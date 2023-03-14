FactoryBot.define do
  factory :bus do
    sequence(:number) { |i| "Bus #{i}" }
    model { 'Икарус' }
  end
end
