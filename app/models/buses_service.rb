# frozen_string_literal: true

class BusesService < ApplicationRecord
  belongs_to :bus
  belongs_to :service
end
