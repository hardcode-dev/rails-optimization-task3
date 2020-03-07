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
  has_and_belongs_to_many :services, join_table: :buses_services

  validates :number, presence: true, uniqueness: true
  validates :model, inclusion: { in: MODELS }

  def self.find_cached_or_create(bus_data)
    @all_buses ||= Bus.all.map{ |bus| [bus.number, bus]}.to_h
    unless  @all_buses[bus_data['number']]
      @all_buses[bus_data['number']] ||= Bus.create!(
          model: bus_data['model'],
          services: Service.find_dumped(bus_data['services']),
          number: bus_data['number'])
    end
    @all_buses[bus_data['number']]
  end
end
