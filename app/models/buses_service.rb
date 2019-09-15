class BusesService < ApplicationRecord
  belongs_to :bus, touch: true
  belongs_to :service, touch: true
end
