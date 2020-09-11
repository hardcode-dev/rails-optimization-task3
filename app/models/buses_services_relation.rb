class BusesServicesRelation < ApplicationRecord
  self.table_name = 'buses_services'

  belongs_to :bus, class_name: 'Bus'
  belongs_to :service, class_name: 'Service'
end