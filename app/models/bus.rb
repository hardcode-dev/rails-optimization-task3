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
  # has_many :buses_services
  # has_many :services, through: :buses_services
  # has_and_belongs_to_many :services, join_table: :buses_services

  validates :number, presence: true, uniqueness: true
  validates :model, inclusion: { in: MODELS }
end
