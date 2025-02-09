FactoryBot.define do
  factory :bus do
    sequence(:number) { |n| "A#{n}23BC" }
    model { Bus::MODELS.sample }
  end
end
