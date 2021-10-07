class BusesServices < ApplicationRecord
  belongs_to :bus
  belongs_to :service

  validates :bus_id, presence: true
  validates :service_id, presence: true
end
