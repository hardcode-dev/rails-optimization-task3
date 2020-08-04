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
  has_and_belongs_to_many :services, join_table: :buses_services

  validates :number, presence: true
  validates :number, uniqueness: { scope: :model }
  validates :model, inclusion: { in: MODELS }
end
