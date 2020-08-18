# == Schema Information
#
# Table name: services
#
#  id   :bigint           not null, primary key
#  name :string
#
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

  has_many :buses_services,
           class_name: 'BusService'

  has_many :buses, through: :buses_services

  validates :name, presence: true
  validates :name, inclusion: { in: SERVICES }
end
