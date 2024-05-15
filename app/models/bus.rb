# == Schema Information
#
# Table name: buses
#
#  id     :bigint           not null, primary key
#  number :string
#  model  :string
#
class Bus < ApplicationRecord
  MODELS = [
    'Икарус',
    'Мерседес',
    'Сканиа',
    'Буханка',
    'УАЗ',
    'Спринтер',
    'ГАЗ',
    'ПАЗ',
    'Вольво',
    'Газель',
  ].freeze

  has_many :trips
  has_many :bus_services, class_name: 'BusService'
  has_many :services, through: :bus_services

  validates :number, presence: true, uniqueness: true
  validates :model, inclusion: { in: MODELS }
end
