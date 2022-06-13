# == Schema Information
#
# Table name: trips
#
#  id               :bigint           not null, primary key
#  duration_minutes :integer
#  price_cents      :integer
#  start_time       :string
#  bus_id           :integer
#  from_id          :integer
#  to_id            :integer
#
# Indexes
#
#  index_trips_on_from_id_and_to_id  (from_id,to_id)
#
# Foreign Keys
#
#  fk_rails_...  (from_id => cities.id) ON DELETE => cascade
#  fk_rails_...  (to_id => cities.id) ON DELETE => cascade
#
class Trip < ApplicationRecord
  HHMM_REGEXP = /([0-1][0-9]|[2][0-3]):[0-5][0-9]/

  belongs_to :from, class_name: 'City', autosave: true, inverse_of: 'trip_from'
  belongs_to :to, class_name: 'City', autosave: true, inverse_of: 'trip_to'
  belongs_to :bus

  validates :from, presence: true
  validates :to, presence: true
  validates :bus, presence: true

  validates :start_time, format: { with: HHMM_REGEXP, message: 'Invalid time' }
  validates :duration_minutes, presence: true
  validates :duration_minutes, numericality: { greater_than: 0 }
  validates :price_cents, presence: true
  validates :price_cents, numericality: { greater_than: 0 }

  def to_h
    {
      from: from.name,
      to: to.name,
      start_time: start_time,
      duration_minutes: duration_minutes,
      price_cents: price_cents,
      bus: {
        number: bus.number,
        model: bus.model,
        services: bus.services.map(&:name),
      },
    }
  end
end
