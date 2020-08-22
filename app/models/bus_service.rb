# frozen_string_literal: true

class BusService < ApplicationRecord
  self.table_name = :buses_services

  belongs_to :service
  belongs_to :bus

  validates :bus_id, uniqueness: { scope: :service_id }
end
