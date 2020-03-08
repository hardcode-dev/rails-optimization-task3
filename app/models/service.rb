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

  has_and_belongs_to_many :buses, join_table: :buses_services, :foreign_key => :service_id, association_foreign_key: [:number, :model]

  validates :name, presence: true
  validates :name, inclusion: { in: SERVICES }
end
