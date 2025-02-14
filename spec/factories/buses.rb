FactoryBot.define do
  factory :bus do
    initialize_with do
      Bus.find_or_create_by(number:)
    end
    
    number { rand(10000).to_s }
    model { Bus::MODELS.sample }
  end
end