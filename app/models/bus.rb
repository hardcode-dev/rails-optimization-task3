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
    ЛиАЗ
  ].freeze

  SERVICES = [
    'WiFi', # 0
    'Туалет',                      # 1
    'Работающий туалет',           # 2
    'Ремни безопасности',          # 3
    'Кондиционер общий',           # 4
    'Кондиционер Индивидуальный',  # 5
    'Телевизор общий',             # 6
    'Телевизор индивидуальный',    # 7
    'Стюардесса',                  # 8
    'Можно не печатать билет'      # 9
  ].freeze

  has_many :trips

  validates :number, presence: true, uniqueness: true

  enum model: MODELS
end
