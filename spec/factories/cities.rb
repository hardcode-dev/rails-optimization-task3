FactoryBot.define do
  factory :city do
    name { 'Москва' }
  end

  trait :owlet do
    name { 'Вигодощи' }
  end
end