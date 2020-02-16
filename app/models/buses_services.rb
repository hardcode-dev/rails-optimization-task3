class BusesServices < ApplicationRecord
  include Dbclear

  belongs_to :bus
  belongs_to :service
end
