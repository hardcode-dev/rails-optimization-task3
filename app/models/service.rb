class Service < ApplicationRecord
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

  has_many :bus_services, dependent: :delete_all
  has_many :buses, through: :bus_services
  # has_and_belongs_to_many :buses, join_table: :buses_services

  validates :name, presence: true
  validates :name, inclusion: { in: SERVICES }
end
