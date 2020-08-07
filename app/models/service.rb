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

  has_and_belongs_to_many :buses, join_table: :buses_services

  validates :name, presence: true
  validates :name, inclusion: { in: SERVICES }

  def self.setup
    columns = [:name]
    values = SERVICES.map { |s| [s] }
    self.import columns, values, validate: true
  end
end
