require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'Валидация названия города' do
    context 'Название содержит пробелы' do
      let(:city) { FactoryBot.build(:city, name: 'Новые Васюки') }

      it 'Появляется ошибка' do
        city.save
        expect(city.errors.messages).to eq({ name: ["has spaces"] })
      end
    end

    context 'Название содержит не робелы' do
      let!(:city) { FactoryBot.create(:city) }

      it 'Модель сохраняется' do
        expect(city.persisted?).to eq true
      end
    end
  end
end
