# frozen_string_literal: true

class BusesServices < ApplicationRecord
  belongs_to :bus
  belongs_to :service
end
