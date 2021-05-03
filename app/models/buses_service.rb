class BusesService < ApplicationRecord
  belongs_to :bus
  belongs_to :service

  validates :bus, presence: true
  validates :service, presence: true
end
