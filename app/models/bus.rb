class ServicesValidator < ActiveModel::Validator
  def validate(record)
    record.services.each do |s|
      unless Bus::SERVICES.include?(s)
        record.errors.add :services, "Buses do not have such service"
      end
    end
  end
end

class Bus < ApplicationRecord
  MODELS = [
    'Икарус',
    'Мерседес',
    'Сканиа',
    'Буханка',
    'УАЗ',
    'Спринтер',
    'ГАЗ',
    'ПАЗ',
    'Вольво',
    'Газель',
  ].freeze

  SERVICES = [
    'WiFi',
    'Туалет',
    'Работающий туалет',
    'Ремни безопасности',
    'Кондиционер общий',
    'Кондиционер Индивидуальный',
    'Телевизор общий',
    'Телевизор индивидуальный',
    'Стюардесса',
    'Можно не печатать билет',
  ].freeze


  has_many :trips
  #has_and_belongs_to_many :services, join_table: :buses_services

  validates :number, presence: true, uniqueness: true
  validates :model, inclusion: { in: MODELS }
  validates_with ServicesValidator, fields: [:services]

end
