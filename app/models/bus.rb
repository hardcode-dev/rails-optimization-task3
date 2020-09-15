# frozen_string_literal: true

class Bus < ApplicationRecord
  MODELS = %w[
    Икарус
    Мерседес
    Сканиа
    Буханка
    УАЗ
    Спринтер
    ГАЗ
    ПАЗ
    Вольво
    Газель
  ].freeze

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

  has_many :trips

  validates :number, presence: true, uniqueness: true
  validates :model, inclusion: { in: MODELS }

  def take_services
    services.map {|service_id| SERVICES[service_id]}.sort
  end
end
