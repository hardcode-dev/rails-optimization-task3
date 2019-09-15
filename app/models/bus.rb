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

  has_many :trips
  has_many :buses_services, class_name: 'BusesService'
  has_many :services, through: :buses_services, class_name: 'Service'

  validates :number, presence: true, uniqueness: true
  validates :model, inclusion: { in: MODELS }
end
