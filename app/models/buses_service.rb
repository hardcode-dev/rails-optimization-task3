# frozen_string_literal: true

# Base BusService class
class BusesService < ApplicationRecord
  belongs_to :bus
  belongs_to :service
end
