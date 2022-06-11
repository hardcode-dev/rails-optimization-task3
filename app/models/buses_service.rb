# == Schema Information
#
# Table name: buses_services
#
#  id         :bigint           not null, primary key
#  bus_id     :integer
#  service_id :integer
#
# Indexes
#
#  index_buses_services_on_bus_id_and_service_id  (bus_id,service_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (bus_id => buses.id)
#  fk_rails_...  (service_id => services.id)
#
class BusesService < ApplicationRecord
  belongs_to :bus
  belongs_to :service
end
