FactoryBot.define do
  factory :bus do
    number { rand(1..999).to_s.rjust(3, "0") }
    model { Bus::MODELS.sample }
  end
end
