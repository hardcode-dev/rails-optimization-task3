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

  self.primary_keys = :number, :model

  has_many :trips, :foreign_key => [:number, :model]
  has_and_belongs_to_many :services, join_table: :buses_services, :foreign_key => [:number, :model]

  validates :number, presence: true, uniqueness: true
  validates :model, inclusion: { in: MODELS }
end
