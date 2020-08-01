class Service < ApplicationRecord
  self.primary_key = 'name'

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

  has_many :staffings
  has_many :buses, through: :staffings

  validates :name, presence: true
  validates :name, inclusion: { in: SERVICES }
end
