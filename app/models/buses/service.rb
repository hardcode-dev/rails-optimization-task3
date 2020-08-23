# == Schema Information
#
# Table name: buses_services
#
#  id         :bigint           not null, primary key
#  bus_id     :integer
#  service_id :integer
#

class Buses::Service < ApplicationRecord
  self.table_name = 'buses_services'

  belongs_to :bus
  belongs_to :service
end
