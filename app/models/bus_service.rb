class BusService < ApplicationRecord
  self.table_name = 'buses_services'

  belongs_to :bus
  belongs_to :service
end
