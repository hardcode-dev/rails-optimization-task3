# frozen_string_literal: true

# Base Bus class
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

  has_many :trips, dependent: :destroy
  has_many :buses_services, dependent: :destroy
  has_many :services, through: :buses_services

  validates :number, presence: true, uniqueness: true
  validates :model, inclusion: { in: MODELS }
end
