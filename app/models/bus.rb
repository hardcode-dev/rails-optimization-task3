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

  has_many :trips
  has_and_belongs_to_many :services, join_table: :buses_services

  enum :model, enum_from_array(MODELS)

  validates :number, presence: true, uniqueness: true
end
