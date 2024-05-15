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

  has_many :service_buses
  has_many :buses, through: :service_buses

  validates :name, presence: true
  validates :name, inclusion: { in: SERVICES }
end
