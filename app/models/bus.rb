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

  validates :number, presence: true, uniqueness: true
  validates :model, inclusion: { in: MODELS }
  validates :services, array_inclusion: { in: SERVICES }
end
