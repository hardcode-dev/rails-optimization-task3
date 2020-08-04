class Bus < ApplicationRecord
  self.primary_key = 'number'

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

  has_many :staffings
  has_many :services, through: :staffings

  validates :number, presence: true, uniqueness: true
  validates :model, inclusion: { in: MODELS }

end
