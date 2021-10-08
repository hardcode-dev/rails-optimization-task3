class BusesServices < ApplicationRecord
  belongs_to :bus, foreign_key: :bus_number, primary_key: :number
  belongs_to :service

  validates :bus_number, presence: true
  validates :service_id, presence: true
end
