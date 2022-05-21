# frozen_string_literal: true

# Base Service class
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
    'Можно не печатать билет'
  ].freeze

  has_many :buses_services, dependent: :destroy
  has_many :bus, through: :buses_services

  validates :name, presence: true
  validates :name, inclusion: { in: SERVICES }
end
